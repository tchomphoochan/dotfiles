return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require("lspconfig")
    lspconfig.clangd.setup({})
    vim.diagnostic.config({
      -- update_in_insert = true,
      -- float = {
      --   focusable = false,
      --   style = "minimal",
      --   border = "rounded",
      --   source = "always",
      --   header = "",
      --   prefix = "",
      -- }
    })
  end
}
