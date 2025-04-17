-- Adapted from
-- https://github.mit.edu/6004/minispec/blob/master/syntax/vim.md

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {"*.bsv", "*.ms"},
  callback = function ()
    vim.opt.syntax = "on"
    vim.opt.filetype = "bsv"
  end
})
