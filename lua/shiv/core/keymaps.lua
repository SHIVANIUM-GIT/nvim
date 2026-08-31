-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap.set("n", "<leader>o", "<cmd>w!<CR><cmd>source %<CR>", { desc = "Save and reload current file" })
keymap.set("n", "<leader>w", "<cmd>w!<CR>", { desc = "Save current buffer" })
keymap.set("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit current buffer" })

-- clear search highlights

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

--switch between splits
keymap.set("n", "<leader>h", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<leader>j", "<C-w>j", { desc = "Move to bottom split" })
keymap.set("n", "<leader>k", "<C-w>k", { desc = "Move to top split" })
keymap.set("n", "<leader>l", "<C-w>l", { desc = "Move to right split" })

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- spell check keymaps
keymap.set("n", "<leader>sp", "<cmd>setlocal spell!<CR>", { desc = "Toggle spell check" })
keymap.set("n", "<leader>ss", "<cmd>Telescope spell_suggest<CR>", { desc = "Spell suggestions in Telescope" })

-- Remote SSH keymaps
keymap.set("n", "<leader>rs", "<cmd>RemoteStart<CR>", { desc = "Connect to Remote SSH" })
keymap.set("n", "<leader>rx", "<cmd>RemoteStop<CR>", { desc = "Stop/Disconnect Remote SSH" })
keymap.set("n", "<leader>ri", "<cmd>RemoteInfo<CR>", { desc = "Show Remote SSH info" })