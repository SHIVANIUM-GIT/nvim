local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  -- Calculate the center position
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local function toggle_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window({ buf = state.floating.buf })
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    vim.cmd('startinsert')
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

-- Create a user command to toggle the terminal
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})

-- Keybindings
local keymap = vim.keymap
keymap.set({ "n", "t" }, "<leader>tt", toggle_terminal, { desc = "Toggle Floating Terminal" })

-- Easy exit from terminal mode to normal mode using ESC twice
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
