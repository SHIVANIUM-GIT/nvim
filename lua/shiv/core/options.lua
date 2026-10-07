local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

-- General options
opt.relativenumber = true
opt.number = true
opt.wrap = true;
opt.termguicolors = true
opt.linebreak = true;

-- tab settings
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

-- spell check settings
opt.spelllang = "en_us"

-- Cursor settings
opt.cursorline = true
opt.guicursor = "n-v-c:block,i-ci:ver25,r-cr:hor20"

-- background settings
cmd("highlight Normal guibg=none")
cmd("syntax on")
opt.signcolumn = "yes"

-- neo-tree (netrwf) settings
-- g.netrw_liststyle = 3

-- backspace settings
opt.backspace = "indent,eol,start"

-- clipboard settings
opt.clipboard = "unnamedplus"

-- split settings
opt.splitright = true
opt.splitbelow = true

-- Performance settings
opt.lazyredraw = true

-- show search matches as you type
opt.incsearch = true

-- keep cursor vertically centered
opt.scrolloff = 999

-- set leader key to space
g.mapleader = " "

-- Auto-center cursor at all times (including end of file)
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  pattern = "*",
  command = "normal! zz",
})
