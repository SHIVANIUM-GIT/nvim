return {
  "amitds1997/remote-nvim.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    -- On Windows, ensure 'sh' and POSIX utilities from Git are available in PATH
    if vim.fn.has("win32") == 1 then
      local git_bin = "C:\\Program Files\\Git\\bin"
      local git_usr_bin = "C:\\Program Files\\Git\\usr\\bin"
      if vim.fn.isdirectory(git_bin) == 1 then
        vim.env.PATH = git_bin .. ";" .. git_usr_bin .. ";" .. vim.env.PATH
      end
    end

    local ssh_config = vim.fn.expand("~/.ssh/config")
    local config_paths = {}
    if vim.fn.filereadable(ssh_config) == 1 then
      table.insert(config_paths, ssh_config)
    end

    require("remote-nvim").setup({
      ssh_config = {
        ssh_config_file_paths = config_paths,
      },
    })
  end,
}
