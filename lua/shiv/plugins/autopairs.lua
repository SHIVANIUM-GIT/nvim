return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true, -- enable treesitter
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javascript template_string
        python = { "string" }, -- don't add pairs in python string nodes
        cpp = { "string", "comment" }, -- don't add pairs in cpp strings/comments
      },
    })
  end,
}
