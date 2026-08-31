return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Fuzzy find files in cwd" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Fuzzy find recent files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Find string in cwd" },
    { "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Find string under cursor in cwd" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Fuzzy find open buffers" },
  },
  
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" },

        file_ignore_patterns = {
          "node_modules",
          "%.git/",
          "%.venv/",
        },

        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob", "!.git/*",
          "--glob", "!node_modules/*",
          "--glob", "!.venv/*",
        },

        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },

      pickers = {
        find_files = {
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
          hidden = true,
        },
      },
    })

    pcall(telescope.load_extension, "fzf")
  end,
}
