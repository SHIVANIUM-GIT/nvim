return {
  "rohan-pckg/tango-themes",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("tango")

    -- Enable transparent background manually
    local hl_groups = {
      "Normal", "NormalNC", "NormalFloat", "LineNr", "EndOfBuffer", 
      "SignColumn", "FoldColumn", "VertSplit", "WinSeparator"
    }
    for _, name in ipairs(hl_groups) do
      vim.api.nvim_set_hl(0, name, { bg = "none", ctermbg = "none" })
    end
  end,
}
