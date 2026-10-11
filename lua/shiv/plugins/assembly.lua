return {
  "0xdeadf1sh/AssemblyForNeovim",
  ft = { "c", "cpp", "rust" },
  cmd = "Asm",
  config = function()
    local asm = require("asm")
    asm.setup()

    local function enclosing_fn()
      local ok, node = pcall(vim.treesitter.get_node)
      if not ok or not node then
        return nil
      end
      while node do
        local t = node:type()
        if t:match("function") or t:match("method") then
          local sr, _, er = node:range()
          return sr + 1, er + 1
        end
        node = node:parent()
      end
    end

    -- Map to <leader>as for entire enclosing function
    vim.keymap.set("n", "<leader>as", function()
      local l1, l2 = enclosing_fn()
      asm.show(l1 or vim.fn.line("."), l2 or vim.fn.line("."))
    end, { desc = "Show Assembly for function under cursor" })

    -- Map to <leader>as in visual mode for selected lines
    vim.keymap.set("x", "<leader>as", ":Asm<CR>", { silent = true, desc = "Show Assembly for selection" })

  end,
}