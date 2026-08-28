return {
    "tpope/vim-fugitive",
    keys = {
        { "<leader>gs", vim.cmd.Git, desc = "Git Status" },
        { "<leader>ga", "<cmd>Git add %<CR>", desc = "Git Add (Current File)" },
        { "<leader>gc", ':Git commit -am "', desc = "Git Commit" },
        { "<leader>gp", "<cmd>Git push<CR>", desc = "Git Push" },
        { "<leader>gl", "<cmd>Git pull<CR>", desc = "Git Pull" },
        { "<leader>gf", "<cmd>Git fetch<CR>", desc = "Git Fetch" },
        { "<leader>gh", "<cmd>Git log<CR>", desc = "Git Log" },
        { "<leader>gch", "<cmd>Git checkout HEAD~<CR>", desc = "Git Checkout HEAD~" },
    },
}