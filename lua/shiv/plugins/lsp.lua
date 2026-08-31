return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason (LSP Package Manager)
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp", -- Bridges LSP with cmp
    "hrsh7th/cmp-buffer", -- Source for text in buffer
    "hrsh7th/cmp-path", -- Source for file system paths

    -- Snippets (Required by nvim-cmp)
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- 0. Configure Diagnostics (Inline Errors)
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●", -- Nice solid dot for the inline error
        spacing = 4,
      },
      signs = true,
      underline = true,
      update_in_insert = true, -- Keep errors and hints visible while typing
    })

    -- 1. Setup Mason (the UI to install LSPs)
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- 2. Setup Mason-LSPConfig
    mason_lspconfig.setup({
      -- List language servers you want installed automatically here!
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
        "dockerls",
        "docker_compose_language_service",
      },
      automatic_installation = true,
    })

    -- 3. Set up capabilities for autocompletion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- 4. Setup LSP servers natively for Neovim 0.11+
    local servers = { "lua_ls", "clangd", "pyright", "dockerls", "docker_compose_language_service" }
    for _, server in ipairs(servers) do
      if server == "lua_ls" then
        vim.lsp.config("lua_ls", {
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" }, -- Don't complain about 'vim' being undefined
              },
            },
          },
        })
      elseif server == "clangd" then
        vim.lsp.config("clangd", {
          capabilities = capabilities,
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        })
      else
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end
      vim.lsp.enable(server)
    end

    -- 5. Setup nvim-cmp (The autocompletion menu)
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- LSP suggestions
        { name = "luasnip" },  -- Snippets
        { name = "buffer" },   -- Text within current buffer
        { name = "path" },     -- File system paths
      }),
    })

    -- 6. Global LSP Keybindings (only active when an LSP attaches to a buffer)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap
        
        opts.desc = "Show LSP references"
        keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
        
        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        
        opts.desc = "Go to definition"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        
        opts.desc = "Show LSP implementations"
        keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
        
        opts.desc = "Show LSP type definitions"
        keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
        
        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        
        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        
        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
        
        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        
        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        
        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        
        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)
      end,
    })
  end,
}
