return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
    if vim.fn.isdirectory(ts_runtime) == 1 then
      vim.opt.rtp:prepend(ts_runtime)
    end

    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Automatically enable Treesitter syntax highlighting for all filetypes
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
