return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup()

    require("nvim-treesitter").install({
      "vimdoc", "javascript", "typescript", "c", "cpp", "lua", "rust",
      "jsdoc", "bash", "python", "ruby", "java", "scala",
    })

    local max_filesize = 100 * 1024 -- 100 KB

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf = args.buf
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          vim.notify(
            "File larger than 100KB treesitter disabled for performance",
            vim.log.levels.WARN,
            { title = "Treesitter" }
          )
          return
        end

        -- Enable treesitter highlighting (and markdown regex on top, like your old
        -- additional_vim_regex_highlighting = { "markdown" })
        local ok_hl = pcall(vim.treesitter.start, buf)
        if ok_hl and vim.bo[buf].filetype == "markdown" then
          vim.bo[buf].syntax = "ON"
        end

        -- Enable treesitter-based indentation
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}
