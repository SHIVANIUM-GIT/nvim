return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local ok, configs = pcall(require, "nvim-treesitter.configs")
    if not ok then
      return
    end

    configs.setup({
      ensure_installed = {
        "python",
        "lua",
        "bash",
        "go",
        "dockerfile",
        "yaml",
        "json",
        "toml",
        "hcl",
        "helm",
        "markdown",
        "regex",
        "vim",
        "groovy",
        "gitignore",
      },

      auto_install = true,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        disable = { "yaml" },
      },
    })
  end,
}
