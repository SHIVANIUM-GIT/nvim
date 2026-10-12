return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason (LSP Package Manager)
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion & Snippets
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    -- High-Performance Lua API support (replaces slow neodev)
    {
      "folke/lazydev.nvim",
      ft = "lua",
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },

    -- Smooth, async LSP progress notifications
    {
      "j-hui/fidget.nvim",
      opts = {
        notification = {
          window = {
            winblend = 0,
            border = "rounded",
          },
        },
      },
    },

    -- VS Code-like pictograms for completion menu
    "onsails/lspkind.nvim",

    -- Sync file renames across imports in nvim-tree
    {
      "antosha417/nvim-lsp-file-operations",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = true,
    },
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- 0. Diagnostics Configuration (Tuned for Zero Typing Lag)
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        spacing = 4,
      },
      float = {
        border = "rounded",
        source = "always",
      },
      signs = true,
      underline = true,
      -- PERFORMANCE: false prevents re-parsing errors on every keystroke, keeping typing at 120fps
      update_in_insert = false,
      severity_sort = true,
    })

    -- Rounded borders for LSP popups (hover & signature help) without deprecated vim.lsp.with
    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
      return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
    end
    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
      return vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_extend("force", config or {}, { border = "rounded" }))
    end

    -- 1. Setup Mason
    mason.setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- 2. Setup Mason-LSPConfig
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        "pyright",
        "rust_analyzer",
        "dockerls",
        "docker_compose_language_service",
      },
      automatic_installation = true,
    })

    -- 3. Set up capabilities for autocompletion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    -- Helper function: auto-detect Python virtual environment (.venv, venv, env, etc.)
    local function get_python_path(root_dir)
      local venv_names = { ".venv", "venv", "env", ".conda" }

      for _, venv_name in ipairs(venv_names) do
        local unix_python = root_dir .. "/" .. venv_name .. "/bin/python"
        local windows_python = root_dir .. "/" .. venv_name .. "/Scripts/python.exe"

        if vim.fn.executable(unix_python) == 1 then
          return unix_python, venv_name
        end
        if vim.fn.executable(windows_python) == 1 then
          return windows_python, venv_name
        end
      end

      -- Check active shell environment ($VIRTUAL_ENV)
      if vim.env.VIRTUAL_ENV then
        local unix_python = vim.env.VIRTUAL_ENV .. "/bin/python"
        local windows_python = vim.env.VIRTUAL_ENV .. "/Scripts/python.exe"
        if vim.fn.executable(unix_python) == 1 then
          return unix_python
        elseif vim.fn.executable(windows_python) == 1 then
          return windows_python
        end
      end

      -- System fallback
      local python3 = vim.fn.exepath("python3")
      if python3 ~= "" then
        return python3
      end
      local python = vim.fn.exepath("python")
      if python ~= "" then
        return python
      end
      return "python"
    end

    -- 4. Setup LSP servers natively with peak performance settings
    local servers = {
      "lua_ls",
      "clangd",
      "pyright",
      "rust_analyzer",
      "dockerls",
      "docker_compose_language_service",
    }

    for _, server in ipairs(servers) do
      if server == "lua_ls" then
        vim.lsp.config("lua_ls", {
          capabilities = capabilities,
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        })
      elseif server == "clangd" then
        vim.lsp.config("clangd", {
          capabilities = capabilities,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
            "--fallback-style=llvm",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
        })
      elseif server == "pyright" then
        vim.lsp.config("pyright", {
          capabilities = capabilities,
          filetypes = { "python" },
          root_markers = {
            "pyproject.toml",
            "setup.py",
            "setup.cfg",
            "requirements.txt",
            "Pipfile",
            "pyrightconfig.json",
            ".git",
          },
          before_init = function(_, config)
            local root_dir = config.root_dir or vim.fn.getcwd()
            local python_path, venv_name = get_python_path(root_dir)

            config.settings = config.settings or {}
            config.settings.python = config.settings.python or {}
            config.settings.python.analysis = config.settings.python.analysis or {}

            -- PERFORMANCE: openFilesOnly saves gigabytes of RAM on large Python codebases
            config.settings.python.analysis.diagnosticMode = "openFilesOnly"
            config.settings.python.analysis.typeCheckingMode = "basic"
            config.settings.python.analysis.autoSearchPaths = true
            config.settings.python.analysis.useLibraryCodeForTypes = true

            if python_path then
              config.settings.python.pythonPath = python_path
            end

            if venv_name then
              config.settings.python.venvPath = root_dir
              config.settings.python.venv = venv_name
            end
          end,
        })
      elseif server == "rust_analyzer" then
        vim.lsp.config("rust_analyzer", {
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                buildScripts = {
                  enable = true,
                },
              },
              -- Run fast Clippy on crate save without checking external dependencies
              checkOnSave = true,
              check = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
              procMacro = {
                enable = true,
              },
              inlayHints = {
                bindingModeHints = { enable = false },
                chainingHints = { enable = true },
                closingBraceHints = { enable = true, minLines = 25 },
                closureReturnTypeHints = { enable = "never" },
                lifetimeElisionHints = { enable = "never" },
                parameterHints = { enable = true },
                reborrowHints = { enable = "never" },
                typeHints = { enable = true },
              },
            },
          },
        })
      else
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end
      vim.lsp.enable(server)
    end

    -- 5. Setup nvim-cmp (Performance-Tuned Autocompletion)
    cmp.setup({
      performance = {
        debounce = 60, -- 60ms debounce keeps typing lag-free
        throttle = 30,
        fetching_timeout = 200, -- drop slow sources so editor never freezes
        max_view_entries = 25,  -- prevent rendering slowdowns
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "rounded",
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- select = false prevents accidental auto-accept on newline
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 }, -- Instant Neovim API completion
        { name = "nvim_lsp", max_item_count = 20 },
        { name = "luasnip", max_item_count = 5 },
        { name = "buffer", keyword_length = 3, max_item_count = 5 }, -- don't trigger buffer scan on 1 letter
        { name = "path", max_item_count = 5 },
      }),
      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
      },
      experimental = {
        ghost_text = true, -- Modern Copilot-style inline ghost completion
      },
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

        -- Toggle Inlay Hints (Rust, Clangd, Pyright, etc.)
        opts.desc = "Toggle Inlay Hints"
        keymap.set("n", "<leader>ih", function()
          local current = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
          vim.lsp.inlay_hint.enable(not current, { bufnr = ev.buf })
        end, opts)
      end,
    })
  end,
}
