return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  lazy = false,
  keys = {
    { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    {
      "<leader>bd",
      function()
        local ok, bufremove = pcall(require, "mini.bufremove")
        if ok then
          bufremove.delete(0, false)
        else
          vim.cmd("bdelete")
        end
      end,
      desc = "Close Current Buffer",
    },
    { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin Buffer" },
    { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close Buffers to Right" },
    { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close Buffers to Left" },
  },
  opts = {
    options = {
      mode = "buffers",
      style_preset = "default",
      always_show_bufferline = true,
      show_buffer_close_icons = true,
      show_close_icon = true,
      separator_style = "slant",
      color_icons = true,
      modified_icon = "●",
      close_icon = "",
      indicator = {
        style = "icon",
        icon = "▎",
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
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
