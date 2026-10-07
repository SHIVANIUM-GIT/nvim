return {
  "romgrk/barbar.nvim",
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  lazy = false,
  init = function()
    vim.g.barbar_auto_setup = false
  end,
  keys = {
    { "<Tab>", "<cmd>BufferNext<CR>", desc = "Next Buffer" },
    { "<S-Tab>", "<cmd>BufferPrevious<CR>", desc = "Previous Buffer" },
    { "<leader>bd", "<cmd>BufferClose<CR>", desc = "Close Current Buffer" },
    { "<leader>bo", "<cmd>BufferCloseAllButCurrent<CR>", desc = "Close Other Buffers" },
    { "<leader>bp", "<cmd>BufferPin<CR>", desc = "Toggle Pin Buffer" },
  },
  config = function()
    require("barbar").setup({
      animation = false,

      -- Enable/disable current/total tabpages indicator (top right corner)
      tabpages = true,

      -- A buffer to this direction will be focused (if it exists) when closing the current buffer.
      focus_on_close = 'left',

      -- Hide inactive buffers and file extensions.
      hide = {extensions = false, inactive = false},

      icons = {
        buffer_index = false,
        buffer_number = false,
        button = '',
        diagnostics = {
          [vim.diagnostic.severity.ERROR] = {enabled = true, icon = ' '},
        },
        gitsigns = {
          added = {enabled = true, icon = '[+] '},
          changed = {enabled = true, icon = '[o] '},
          deleted = {enabled = true, icon = '[-] '},
        },
        separator = {left = '▎', right = ''},

        -- If true, add an additional separator at the end of the buffer list
        separator_at_end = true,

        modified = {button = '●'},
        pinned = {button = '', filename = true},

        alternate = {filetype = {enabled = false}},
        current = {buffer_index = true},
        inactive = {button = '×'},
        visible = {modified = {buffer_number = false}},
      },

      sidebar_filetypes = {
        NvimTree = true,
        undotree = { text = 'undotree', align = 'left' },
        ['neo-tree'] = {event = 'BufWipeout'},
        Outline = {event = 'BufWinLeave', text = 'symbols-outline', align = 'right'},
      },
      maximum_length = 25,
    })
  end
}
