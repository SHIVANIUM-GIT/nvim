local opt = vim.opt
local cmd = vim.cmd
local g = vim.g

-- General options
-- opt.relativenumber = true
opt.number = true
opt.wrap = false

-- tab settings
opt.tabstop = 2
-- opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- search settings
opt.ignorecase = true
opt.smartcase = true

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