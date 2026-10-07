local M = {}

-- Store the current context string
local current_context = ""

-- Set updatetime so CursorHold triggers faster (200ms)
vim.opt.updatetime = 200

-- Asynchronously fetch document symbols from LSP when the cursor stops moving
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    -- Only run if there is an active LSP client
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients == 0 then return end

    local params = { textDocument = vim.lsp.util.make_text_document_params() }
    vim.lsp.buf_request(0, "textDocument/documentSymbol", params, function(err, result)
      if err or not result or #result == 0 then
        current_context = ""
        vim.cmd("redrawstatus")
        return
      end

      local cursor_pos = vim.api.nvim_win_get_cursor(0)
      local line = cursor_pos[1] - 1

      -- Recursive function to find the deepest symbol that contains the cursor
      local function find_symbol(symbols, current_match)
        for _, symbol in ipairs(symbols) do
          local range = symbol.range or (symbol.location and symbol.location.range)
          if range and range.start.line <= line and range["end"].line >= line then
            current_match = symbol.name
            if symbol.children then
              current_match = find_symbol(symbol.children, current_match)
            end
          end
        end
        return current_match
      end

      local match = find_symbol(result, "")
      if match and match ~= "" then
        current_context = "  " .. match
      else
        current_context = ""
      end

      -- Request a redraw of the statusline/winbar to show the new context
      vim.cmd("redrawstatus")
    end)
  end
})

-- The function that Neovim will call to render the winbar
function _G.ShivNativeWinbar()
  -- Get the file path relative to the current directory
  local file_path = vim.fn.expand("%:~:.")
  if file_path == "" then return "" end

  -- Add a file icon if nvim-web-devicons is present
  local icon = "📄"
  local ok, devicons = pcall(require, "nvim-web-devicons")
  if ok then
    local ext = vim.fn.expand("%:e")
    local icon_str = devicons.get_icon_color(vim.fn.expand("%:t"), ext, { default = true })
    if icon_str then icon = icon_str end
  end

  -- Combine the icon, file path, and the LSP context
  return " " .. icon .. " %#Directory#" .. file_path .. "%*" .. "%#String#" .. current_context .. "%*"
end

-- Enable the native winbar globally
vim.opt.winbar = "%{%v:lua.ShivNativeWinbar()%}"

return M
