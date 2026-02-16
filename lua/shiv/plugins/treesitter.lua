return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- important!
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "bash", "python", "json" },
      highlight = {
        enable = true,
      },
    })
  end,
}
