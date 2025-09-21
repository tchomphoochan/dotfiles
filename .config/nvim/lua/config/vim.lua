-- Vim options
vim.cmd.colorscheme("tokyonight")

-- line number
vim.opt.number = true
vim.opt.relativenumber = true
 
-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
 
-- visuals
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
 
-- search
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- window splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- clipbaord
vim.opt.clipboard = "unnamedplus"

-- no, thanks, ftplugin
vim.g.python_recommended_style = false
vim.g.rust_recommended_style = false
vim.g.go_recommended_style = false
vim.g.ruby_recommended_style = false
vim.g.zig_recommended_style = false
vim.g.markdown_recommended_style = false
vim.g.meson_recommended_style = false
vim.g.arduino_recommended_style = false
vim.g.sass_recommended_style = false
