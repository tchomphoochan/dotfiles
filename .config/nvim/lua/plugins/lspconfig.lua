--[[
Configure nvim-lspconfig for C projects to:
  - Automatically detect project root based on Makefile, .git, or fallback to current working directory.
  - Prefer using compile_commands.json if available (even if located inside build/)
  - Otherwise, dry-run 'make -n' or fallback to recursively scanning header/source files (.h/.hpp/.c/.cpp)
  - Provide fallbackFlags only if compile_commands.json is missing
  - Allow user to manually switch modes via :LspMode <mode>
  - Open source files hiddenly to help clangd background indexing
  - Restart clangd safely (deferred)
  - Cache scanned results per project session
  - Cleanly print make errors to mini-buffer
  - Provide <leader>li to view flags and detected project root, <leader>lr to reload clangd

Notes:
  - This file configures *only* 'nvim-lspconfig' for lazy.nvim.
  - If you regenerate, please update this header.

Architecture Design:
  - Project root detection is independent of mode detection.
  - Always find project root first based on Makefile, .git, or fallback to cwd.
  - After root is known, separately search for compile_commands.json inside root or root/build.
  - Decide mode: compile_commands.json -> make -> treewalk.
  - Allow overriding mode manually by user.
  - init_options must be a static Lua table (no functions allowed).
  - fallbackFlags must be computed before clangd setup.

Important Implementation Notes:
  - Do not attempt to dynamically compute init_options; clangd expects a plain Lua table.
  - Always sanitize and deduplicate include flags.
  - Always make -I paths absolute relative to root.
  - Treat Makefile errors as non-fatal; fallback gracefully.
  - fallbackFlags should be empty when using compile_commands.json mode.
  - Maintain caching for flags and mode per project root to improve performance.
  - When opening hidden files for background indexing, delay slightly to avoid contention.

Known Bugs to Be Aware of:
  1. When opening a .h file first, clangd may fail to jump to the corresponding .cpp file.
  2. Occasionally, table.concat() will fail with nil values in the lines being concatenated.
  3. Make sure clangd doesn't display any errors related to undefined variables or missing flags if make -n fails.
  4. Ensure that modes (compile_commands, make, treewalk) are correctly detected and applied.
  5. Ensure all configurations occur after plugin and LSP are fully loaded.
  6. Make sure all include paths are absolute paths.
  7. When modifying this config, always check the integrity of flags and ensure they are valid for clangd to process.
]]

return {
  'neovim/nvim-lspconfig',
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lspconfig = require('lspconfig')
    local uv = vim.loop
    local cache = {}
    local forced_mode = {}

    local function find_project_root(bufname)
      local root = lspconfig.util.root_pattern('Makefile', '.git')(bufname)
      if root then
        return root
      else
        return vim.fn.getcwd()
      end
    end

    local function find_compile_commands(root)
      if uv.fs_stat(root .. '/compile_commands.json') then
        return root .. '/compile_commands.json'
      elseif uv.fs_stat(root .. '/build/compile_commands.json') then
        return root .. '/build/compile_commands.json'
      else
        return nil
      end
    end

    local function sanitize_flags(flags)
      local seen = {}
      local result = {}
      for _, flag in ipairs(flags) do
        if not seen[flag] then
          table.insert(result, flag)
          seen[flag] = true
        end
      end
      return result
    end

    local function get_make_flags(root)
      local cmd = 'make -n -C ' .. root
      local handle = io.popen(cmd .. ' 2>&1')
      local result = handle:read('*a')
      handle:close()
      if result:match("No rule to make target") or result:match("error") then
        vim.notify("Error while processing Makefile in project root: " .. root .. "\nError message: " .. result, vim.log.levels.ERROR)
        return {}, 'error'
      end
      local flags = {}
      for flag in result:gmatch('%-[ID]%s*[^%s]+') do
        if flag:sub(1, 2) == "-I" then
          local dir = flag:sub(3)
          if dir:sub(1, 1) == '.' then
            dir = root .. '/' .. dir:sub(3)
          end
          table.insert(flags, "-I" .. dir)
        else
          table.insert(flags, flag)
        end
      end
      return sanitize_flags(flags), 'make'
    end

    local function scan_headers_sources(root)
      local flags = {}
      local scan = vim.fn.globpath(root, '**/{*.h,*.hpp,*.c,*.cpp}', 0, 1)
      local seen = {}
      for _, file in ipairs(scan) do
        local dir = file:match("(.*/)")
        if dir and not seen[dir] then
          table.insert(flags, '-I' .. dir)
          seen[dir] = true
        end
      end
      return sanitize_flags(flags), 'treewalk'
    end

    local function determine_fallback_flags(root)
      if cache[root] then
        return cache[root].flags, cache[root].mode
      end

      local forced = forced_mode[root]
      if forced == 'compile_commands' then
        if find_compile_commands(root) then
          cache[root] = { flags = {}, mode = 'compile_commands.json' }
          return {}, 'compile_commands.json'
        else
          vim.notify("Forced mode compile_commands not applicable: compile_commands.json not found.", vim.log.levels.ERROR)
        end
      elseif forced == 'make' then
        local flags, mode = get_make_flags(root)
        if #flags > 0 then
          cache[root] = { flags = flags, mode = 'make' }
          return flags, 'make'
        else
          vim.notify("Forced mode make not applicable: make failed.", vim.log.levels.ERROR)
        end
      elseif forced == 'treewalk' then
        local flags, mode = scan_headers_sources(root)
        cache[root] = { flags = flags, mode = 'treewalk' }
        return flags, 'treewalk'
      end

      local compile_commands = find_compile_commands(root)
      if compile_commands then
        cache[root] = { flags = {}, mode = 'compile_commands.json' }
        return {}, 'compile_commands.json'
      end

      local flags, mode = get_make_flags(root)
      if #flags == 0 then
        flags, mode = scan_headers_sources(root)
      end

      cache[root] = { flags = flags, mode = mode }
      return flags, mode
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()

    local root_for_init = find_project_root(vim.fn.expand('%:p'))
    local flags_for_init, _ = determine_fallback_flags(root_for_init)

    lspconfig.clangd.setup({
      capabilities = capabilities,
      root_dir = function(fname)
        return find_project_root(fname)
      end,
      cmd = { "clangd", "--background-index", "--clang-tidy" },
      init_options = {
        fallbackFlags = flags_for_init,
      },
      on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<leader>li', function()
          local root = find_project_root(vim.fn.expand('%:p'))
          local flags, mode = determine_fallback_flags(root)
          print("Project root: " .. root .. "\nMode: " .. mode .. "\nFlags:\n" .. table.concat(flags, '\n'))
        end, opts)
        vim.keymap.set('n', '<leader>lr', function()
          vim.defer_fn(function()
            vim.cmd('LspRestart clangd')
          end, 100)
        end, opts)
      end,
    })

    vim.api.nvim_create_user_command('LspMode', function(opts)
      local mode = opts.args
      if mode ~= 'compile_commands' and mode ~= 'make' and mode ~= 'treewalk' then
        vim.notify("Invalid mode. Choose compile_commands, make, or treewalk.", vim.log.levels.ERROR)
        return
      end
      local root = find_project_root(vim.fn.expand('%:p'))
      forced_mode[root] = mode
      cache[root] = nil
      vim.notify("Switched LSP mode to " .. mode .. " for root " .. root .. ". Restarting clangd...", vim.log.levels.INFO)
      vim.defer_fn(function()
        vim.cmd('LspRestart clangd')
      end, 100)
    end, { nargs = 1, complete = function() return {'compile_commands', 'make', 'treewalk'} end })

    vim.defer_fn(function()
      local root_dir = find_project_root(vim.fn.expand('%:p'))
      local files = vim.fn.globpath(root_dir, '**/*.{c,cpp}', 0, 1)
      for _, file in ipairs(files) do
        vim.cmd('silent badd ' .. file)
      end
    end, 2000)
  end,
}
