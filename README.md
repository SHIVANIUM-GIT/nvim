# 🚀 Neovim Configuration (Lazy.nvim + Lua)

A modern, fast, and clean **Neovim configuration** built with **Lua** and **lazy.nvim**.  
Optimized for development, DevOps, and daily productivity.

---

## ✨ Features

- ⚡ **Fast startup** with `lazy.nvim`
- 🎨 **Beautiful Aesthetics** with native transparent background & **lualine**
- 🧠 **Native LSP** powered by **Mason** & `vim.lsp.config` for zero-friction intellisense
- 🪄 **Auto-Formatting** on save powered by **conform.nvim**
- 🌳 **Syntax Highlighting** powered by **nvim-treesitter**
- 🔍 **Fuzzy finding** with **Telescope**
- 🐙 **Git Integration** with custom shortcuts (`git-stuff`) and **gitsigns**
- 🔤 **Nerd Font** support (icons everywhere)

---

## 📁 Directory Structure

```text
~/.config/nvim (or ~/AppData/Local/nvim on Windows)
├── init.lua
├── lazy-lock.json
└── lua/
    └── shiv/
        ├── init.lua          # Main Lua entry point
        ├── lazy.lua          # Lazy.nvim setup
        ├── core/
        │   ├── init.lua      # Core entry point
        │   ├── keymaps.lua   # Global keybindings
        │   └── options.lua   # Editor settings (numbers, indent, etc)
        └── plugins/
            ├── autopairs.lua       # Auto-close brackets
            ├── formatting.lua      # Conform (Format on Save)
            ├── git-stuff.lua       # Custom Git Shortcuts
            ├── gitsigns.lua        # Git gutter integration
            ├── indent-blankline.lua# Indent guides
            ├── init.lua            # Lazy Plugin Registry
            ├── lsp.lua             # Mason, cmp, and LSP setup
            ├── lualine.lua         # Statusline
            ├── nvim-tree.lua       # File explorer
            ├── telescope.lua       # Fuzzy finder
            ├── treesitter.lua      # Syntax Highlighting
            └── undotree.lua        # Undo history visualizer
```

---

## 🧰 Requirements

### Neovim & Compilers
- ✔ Recommended: **Neovim ≥ 0.11** (for native `vim.lsp.config` support)
- ✔ C Compiler: **GCC** or **Clang** (Required by Treesitter to compile language parsers)
- ✔ Node.js (`npm`): (Required by Mason to download certain language servers)

*(On Windows, you can quickly install the compiler using Scoop: `scoop install gcc`)*

---

## 🔤 Nerd Font (IMPORTANT)

This configuration heavily uses icons. You **must** install a Nerd Font.

### ✅ Recommended Font
**JetBrainsMono Nerd Font Mono**

After installing it, **set your terminal font** to `JetBrainsMono Nerd Font Mono` and restart your terminal.

---

## 📦 Install This Config

### 1. Backup existing config (if any)
```bash
# Linux / macOS
mv ~/.config/nvim ~/.config/nvim.bak

# Windows (PowerShell)
Rename-Item ~\AppData\Local\nvim nvim.bak
```

### 2. Clone the repository
```bash
git clone https://github.com/SHIVANIUM-GIT/nvim.git ~/.config/nvim
```

### 3. Start Neovim
```bash
nvim
```
`lazy.nvim` will automatically download and install all plugins. **Mason** and **Treesitter** will begin downloading your language servers and parsers in the background.

---

## 🔌 Included Plugins

- **lazy.nvim** – Plugin manager
- **mason.nvim** - Portable package manager for LSPs & Formatters
- **nvim-cmp** & **LuaSnip** - Powerful autocompletion engine
- **conform.nvim** - Lightweight formatter with auto-save support
- **nvim-treesitter** - Advanced syntax highlighting
- **telescope.nvim** – Fuzzy finder
- **nvim-tree.lua** – File explorer
- **lualine.nvim** – Statusline
- **nvim-autopairs** – Auto-closes brackets and quotes
- **indent-blankline.nvim** – Indentation guides
- **undotree** – Visualizes undo history

---

## ⌨️ Keymaps

Keymaps are centrally defined in:
```text
lua/shiv/core/keymaps.lua
```

Leader key: `<Space>`

### 🐙 Custom Git Shortcuts
* `:Gs` - Git Status
* `:Ga` - Git Add All
* `:Gc "message"` - Git Commit
* `:Gp` - Git Push
* `:Gl` - Git Pull
* `:Gf` - Git Fetch
* `:Glog` - Git Log

---

## 🔄 Update Plugins
To update all your plugins, open Neovim and run:
```vim
:Lazy sync
```
To update your Treesitter parsers:
```vim
:TSUpdate
```

---

## 📜 License
MIT
