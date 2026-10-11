return {
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = false,
  config = function()
    local toggleterm = require("toggleterm")
    local Terminal = require("toggleterm.terminal").Terminal

    toggleterm.setup({
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
    })

    -- Persistent dedicated floating terminal
    local float_term = Terminal:new({
      direction = "float",
      hidden = true,
      float_opts = {
        border = "rounded",
        winblend = 0,
      },
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    local function toggle_float()
      float_term:toggle()
    end

    -- Toggle floating terminal seamlessly from BOTH Normal and Terminal mode
    vim.keymap.set({ "n", "t" }, "<leader>tt", toggle_float, { desc = "Toggle Floating Terminal" })

    -- Horizontal and Vertical split toggles
    vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", { desc = "Toggle Horizontal Terminal" })
    vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle Vertical Terminal" })

    -- Navigation and mode exit keymaps inside terminal
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- ESC ESC exits terminal insert mode
      vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)
      -- Seamless window navigation between splits
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*",
      callback = function()
        set_terminal_keymaps()
      end,
    })
  end,
}
