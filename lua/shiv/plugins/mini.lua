return {
  "echasnovski/mini.nvim",
  version = false,
  event = "VeryLazy",
  config = function()
    -- mini.ai: Better and expanded textobjects (around/inside function, argument, etc.)
    require("mini.ai").setup({
      n_lines = 500,
    })

    -- mini.surround: Fast surround actions
    --   sa: add surround (e.g. saiw" surrounds inner word with quotes)
    --   sd: delete surround (e.g. sd" deletes surrounding quotes)
    --   sr: replace surround (e.g. sr"' replaces quotes with single quotes)
    --   sf: find surrounding
    --   sh: highlight surrounding
    require("mini.surround").setup({
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
      },
    })

    -- mini.move: Move any line or visual selection with Alt+h/j/k/l
    require("mini.move").setup({
      mappings = {
        left = "<M-h>",
        right = "<M-l>",
        down = "<M-j>",
        up = "<M-k>",
        line_left = "<M-h>",
        line_right = "<M-l>",
        line_down = "<M-j>",
        line_up = "<M-k>",
      },
    })

    -- mini.splitjoin: Split or join arguments and lists with gS
    require("mini.splitjoin").setup()

    -- mini.bufremove: Remove buffers without ruining window layouts
    require("mini.bufremove").setup()
  end,
}
