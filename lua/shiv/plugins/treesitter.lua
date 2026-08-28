return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" }, -- important!

  config = function()
    -- Bypass Windows git clone permission issues by using curl and tar
    require("nvim-treesitter.install").prefer_git = false
    require("nvim-treesitter.install").compilers = { "gcc" }

    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "bash", "python", "json", "cpp" },
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end,
}
