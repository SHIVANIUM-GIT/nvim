return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- important!

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "bash", "python", "json", "cpp" },
      highlight = {
        enable = true,
      },
    })
  end,
}
