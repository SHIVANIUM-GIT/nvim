return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      require("nvim-treesitter.configs").setup({
        -- Languages to install
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
        },

        -- Automatically install missing parsers
        auto_install = true,

        -- Syntax highlighting
        highlight = {
          enable = true,

          -- Disable highlighting for large files (performance)
          disable = function(_, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(
              vim.loop.fs_stat,
              vim.api.nvim_buf_get_name(buf)
            )

            return ok and stats and stats.size > max_filesize
          end,

          -- Use Treesitter only (recommended)
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  },
}
-- return {
--   "nvim-treesitter/nvim-treesitter",
-- }

