return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")
    local include_formatter = require("shiv.tools.include_formatter")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        c = { "clang-format" },
        cpp = { "clang-format" },
        rust = { "rustfmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      },
      formatters = {
        ["clang-format"] = {
          prepend_args = { "--style={BasedOnStyle: LLVM, PointerAlignment: Left}" },
        },
      },
    })

    -- Automatically format C/C++ includes on save (BufWritePre)
    local group = vim.api.nvim_create_augroup("CppIncludeFormatter", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = { "*.h", "*.hpp", "*.hh", "*.hxx", "*.c", "*.cc", "*.cpp", "*.cxx" },
      callback = function(args)
        include_formatter.format(args.buf)
      end,
      desc = "Automatically format and sort C/C++ includes on save",
    })

    -- User command & keybind to manually format includes
    vim.api.nvim_create_user_command("FormatIncludes", function()
      include_formatter.format(vim.api.nvim_get_current_buf())
      vim.notify("Formatted C/C++ includes", vim.log.levels.INFO)
    end, { desc = "Format and organize C/C++ include directives" })

    vim.keymap.set("n", "<leader>mi", "<cmd>FormatIncludes<CR>", { desc = "Format C/C++ includes" })

    -- Keybind to manually format buffer
    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      local ft = vim.bo.filetype
      if ft == "c" or ft == "cpp" then
        include_formatter.format(vim.api.nvim_get_current_buf())
      end
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 3000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
