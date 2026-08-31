return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous Buffer" },
    { "<leader>bd", "<cmd>bdelete<CR>", desc = "Close Current Buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close Other Buffers" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin Buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      style_preset = "default",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      separator_style = "thin", -- Clean VS Code-like thin separators
      color_icons = true,
      modified_icon = "●",
      close_icon = "",
      indicator = {
        style = "underline", -- Underline active tab like VS Code
      },
      offsets = {
        {
          filetype = "NvimTree",
          text = "EXPLORER",
          highlight = "Directory",
          separator = true,
          text_align = "left",
        },
      },
    },
  },
}
