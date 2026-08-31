# ⚡ Shiv's Neovim Configuration

<div align="center">

![Neovim](https://img.shields.io/badge/Neovim-0.11+-57A143?style=for-the-badge&logo=neovim&logoColor=white)
![Lua](https://img.shields.io/badge/Lua-5.1%20%2F%20Luajit-2C2D72?style=for-the-badge&logo=lua&logoColor=white)
![Lazy.nvim](https://img.shields.io/badge/Plugin%20Manager-Lazy.nvim-blueviolet?style=for-the-badge)
![OS](https://img.shields.io/badge/Platforms-Linux%20%7C%20macOS%20%7C%20Windows-informational?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

<p align="center">
  A blazing-fast, modular, and aesthetic <b>Neovim</b> configuration built with <b>Lua</b>, <b>lazy.nvim</b>, and native <b>Neovim 0.11+ LSP</b> support.
  <br />
  Tailored for software engineering, DevOps (Docker, Kubernetes, Terraform), and remote development.
</p>

</div>

---

## 📑 Table of Contents

- [✨ Features](#-features)
- [📁 Directory Structure](#-directory-structure)
- [🧰 Prerequisites](#-prerequisites)
- [🚀 Installation](#-installation)
- [⌨️ Keybindings Cheat Sheet](#️-keybindings-cheat-sheet)
  - [General & Window Management](#general--window-management)
  - [Tabs & Buffers](#tabs--buffers)
  - [File Navigation & Search (Telescope & Nvim-Tree)](#file-navigation--search-telescope--nvim-tree)
  - [LSP & Code Intelligence](#lsp--code-intelligence)
  - [Formatting & Utilities](#formatting--utilities)
  - [Git Workflow (Fugitive & Gitsigns)](#git-workflow-fugitive--gitsigns)
  - [Remote Development (SSH)](#remote-development-ssh)
- [🔌 Included Plugins](#-included-plugins)
- [🐳 DevOps Shell Aliases](#-devops-shell-aliases)
- [🔄 Maintenance & Updates](#-maintenance--updates)
- [📜 License](#-license)

---

## ✨ Features

- ⚡ **Blazing Fast Startup**: Fully asynchronous lazy-loading driven by [`lazy.nvim`](https://github.com/folke/lazy.nvim).
- 🎨 **Sleek & Transparent UI**: Powered by **Nightfox (`carbonfox`)**, [`lualine.nvim`](https://github.com/nvim-lualine/lualine.nvim) statusline, and [`bufferline.nvim`](https://github.com/akinsho/bufferline.nvim) tab bar with transparent background support.
- 🧠 **Native Neovim 0.11+ LSP**: Integrated with `vim.lsp.config`, [`mason.nvim`](https://github.com/williamboman/mason.nvim), and [`mason-lspconfig.nvim`](https://github.com/williamboman/mason-lspconfig.nvim) for effortless language server management.
- 💡 **Intelligent Autocompletion**: Comprehensive auto-suggestions powered by [`nvim-cmp`](https://github.com/hrsh7th/nvim-cmp) with snippets via [`LuaSnip`](https://github.com/L3MON4D3/LuaSnip).
- 🪄 **Formatting on Save**: Zero-lag asynchronous code formatting with [`conform.nvim`](https://github.com/stevearc/conform.nvim) (Lua, Python, C/C++).
- 🌳 **Rich Syntax Highlighting**: Tree-sitter AST-based parsing and indentation via [`nvim-treesitter`](https://github.com/nvim-treesitter/nvim-treesitter).
- 🔍 **Fast Fuzzy Finding**: Lightning-fast search over files, strings, and diagnostics with [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) and `fzf-native`.
- 🐙 **First-Class Git Integration**: In-editor staging and commits with [`vim-fugitive`](https://github.com/tpope/vim-fugitive) and gutter diff signs with [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim).
- 🌐 **Remote Development**: Effortlessly connect to remote servers over SSH with [`remote-nvim.nvim`](https://github.com/amitds1997/remote-nvim.nvim).
- 📜 **Infinite Undo Visualizer**: Branching undo history tree exploration with [`undotree`](https://github.com/mbbill/undotree).

---

## 📁 Directory Structure

```text
~/.config/nvim (or ~/AppData/Local/nvim on Windows)
├── init.lua                   # Entry point (requires lua/shiv)
├── lazy-lock.json             # Pinned plugin lockfile
├── .bash_aliases              # DevOps shell helper aliases
└── lua/
    └── shiv/
        ├── init.lua           # Loads core configuration & lazy setup
        ├── lazy.lua           # lazy.nvim bootstrap and configuration
        ├── core/
        │   ├── init.lua       # Loads options and general keymaps
        │   ├── keymaps.lua    # Global keybindings & leader mappings
        │   └── options.lua    # Editor settings (indentation, splits, UI)
        └── plugins/
            ├── init.lua            # Plugin registry aggregator
            ├── autopairs.lua       # Bracket auto-pairing
            ├── bufferline.lua      # VS Code-like buffer/tab line
            ├── colorscheme.lua     # Nightfox / Carbonfox theme
            ├── formatting.lua      # Conform (format-on-save)
            ├── git-stuff.lua       # Git fugitive shortcuts
            ├── gitsigns.lua        # Git signs & gutter indicators
            ├── indent-blankline.lua# Clean indentation guides
            ├── lsp.lua             # Mason, nvim-cmp, snippets & LSP config
            ├── lualine.lua         # Statusline configuration
            ├── nvim-tree.lua       # File explorer
            ├── remote-nvim.lua     # Remote SSH development
            ├── telescope.lua       # Fuzzy finder & ripgrep integration
            ├── treesitter.lua      # Treesitter syntax highlighting
            └── undotree.lua        # Visual undo history manager
```

---

## 🧰 Prerequisites

Ensure you have the following installed on your system before setting up:

| Dependency | Purpose | Recommendation |
| :--- | :--- | :--- |
| **Neovim** | Core Editor | **v0.11.0+** (required for `vim.lsp.config`) |
| **Nerd Font** | Icons across UI, Tree & Statusline | **JetBrainsMono Nerd Font** |
| **Git** | Plugin syncing & version control | System Git |
| **C/C++ Compiler** | Treesitter parser compilation | `gcc` / `clang` / `msvc` |
| **ripgrep (`rg`)** | Live grep & fast file search | `ripgrep` |
| **Node.js (`npm`)** | Mason package installations | `v18+` |
| **Python 3 (`pip`)** | Python language tools & formatters | `v3.10+` |

> [!TIP]
> **Windows Installation (via Scoop / Winget):**
> ```powershell
> scoop install neovim gcc ripgrep nodejs python
> ```
> 
> **macOS Installation (via Homebrew):**
> ```bash
> brew install neovim gcc ripgrep node python
> ```
> 
> **Linux (Ubuntu/Debian) Installation:**
> ```bash
> sudo apt install neovim build-essential ripgrep nodejs npm python3
> ```

---

## 🚀 Installation

### 1. Backup Existing Configuration
```bash
# Linux / macOS
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# Windows (PowerShell)
Rename-Item -Path "$env:LOCALAPPDATA\nvim" -NewName "nvim.bak"
Rename-Item -Path "$env:LOCALAPPDATA\nvim-data" -NewName "nvim-data.bak"
```

### 2. Clone the Repository
```bash
# Linux / macOS
git clone https://github.com/SHIVANIUM-GIT/nvim.git ~/.config/nvim

# Windows (PowerShell)
git clone https://github.com/SHIVANIUM-GIT/nvim.git "$env:LOCALAPPDATA\nvim"
```

### 3. Launch Neovim
```bash
nvim
```

`lazy.nvim` will automatically bootstrap and install all plugins. Once loaded:
1. Run `:Mason` to verify installed LSPs (`lua_ls`, `clangd`, `pyright`, `dockerls`, `docker_compose_language_service`).
2. Run `:TSUpdate` to update/compile Treesitter parsers.

---

## ⌨️ Keybindings Cheat Sheet

> The leader key is mapped to **`Space`** (`<leader>`).

### General & Window Management

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `i` | `jk` | Fast exit from insert mode |
| `n` | `<leader>w` | Save current file (`:w!`) |
| `n` | `<leader>q` | Quit current window (`:quit`) |
| `n` | `<leader>o` | Save and reload/source current file |
| `n` | `<leader>+` | Increment number under cursor |
| `n` | `<leader>-` | Decrement number under cursor |
| `v` | `J` | Move selected line(s) down |
| `v` | `K` | Move selected line(s) up |
| `n` | `<leader>sv` | Split window vertically (`:vsplit`) |
| `n` | `<leader>sh` | Split window horizontally (`:split`) |
| `n` | `<leader>se` | Equalize split window dimensions |
| `n` | `<leader>sx` | Close current split window |
| `n` | `<leader>h` | Move focus to left split |
| `n` | `<leader>j` | Move focus to lower split |
| `n` | `<leader>k` | Move focus to upper split |
| `n` | `<leader>l` | Move focus to right split |

### Tabs & Buffers

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `n` | `<Tab>` | Cycle to next buffer (BufferLine) |
| `n` | `<S-Tab>` | Cycle to previous buffer (BufferLine) |
| `n` | `<leader>bd` | Close current buffer |
| `n` | `<leader>bo` | Close all other buffers |
| `n` | `<leader>bp` | Toggle pin on current buffer |
| `n` | `<leader>to` | Open new tab page |
| `n` | `<leader>tx` | Close current tab page |
| `n` | `<leader>tn` | Switch to next tab page |
| `n` | `<leader>tp` | Switch to previous tab page |
| `n` | `<leader>tf` | Open current buffer in new tab |

### File Navigation & Search (Telescope & Nvim-Tree)

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `n` | `<leader>ee` | Toggle file explorer tree |
| `n` | `<leader>ef` | Reveal current file in explorer |
| `n` | `<leader>ec` | Collapse explorer directories |
| `n` | `<leader>er` | Refresh file explorer |
| `n` | `<leader>ff` | Fuzzy find files in project |
| `n` | `<leader>fr` | Fuzzy find recent files |
| `n` | `<leader>fg` | Live grep string in project (`ripgrep`) |
| `n` | `<leader>fs` | Find word under cursor in project |
| `n` | `<leader>fb` | Search active buffers |

### LSP & Code Intelligence

*(Active when an LSP server is attached to the buffer)*

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `n` | `K` | Display hover documentation |
| `n` | `gd` | Go to definition (Telescope) |
| `n` | `gD` | Go to declaration |
| `n` | `gR` | List references (Telescope) |
| `n` | `gi` | Find implementations (Telescope) |
| `n` | `gt` | Find type definitions (Telescope) |
| `n/v`| `<leader>ca` | Show code actions |
| `n` | `<leader>rn` | Smart rename symbol |
| `n` | `<leader>d` | Open floating line diagnostic |
| `n` | `<leader>D` | Show buffer diagnostics list (Telescope) |
| `n` | `[d` | Jump to previous diagnostic |
| `n` | `]d` | Jump to next diagnostic |
| `i` | `<C-j>` / `<C-k>` | Navigate completion items |
| `i` | `<C-Space>` | Trigger autocompletion |
| `i` | `<CR>` | Confirm autocompletion item |

### Formatting & Utilities

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `n/v`| `<leader>mp` | Format buffer or selection via Conform |
| `n` | `<leader>u` | Toggle visual UndoTree panel |
| `n` | `<leader>sp` | Toggle spell checking |
| `n` | `<leader>ss` | Show spell suggestions in Telescope |

### Git Workflow (Fugitive & Gitsigns)

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `n` | `<leader>gs` | Open interactive Git status (`:Git`) |
| `n` | `<leader>ga` | Git add current file (`:Git add %`) |
| `n` | `<leader>gc` | Commit staged changes (`:Git commit -am "`) |
| `n` | `<leader>gp` | Push to remote (`:Git push`) |
| `n` | `<leader>gl` | Pull from remote (`:Git pull`) |
| `n` | `<leader>gf` | Fetch from remote (`:Git fetch`) |
| `n` | `<leader>gh` | View commit history log (`:Git log`) |
| `n` | `<leader>gch` | Checkout previous commit (`HEAD~`) |

### Remote Development (SSH)

| Mode | Shortcut | Action |
| :--- | :--- | :--- |
| `n` | `<leader>rs` | Start / Connect to remote SSH workspace |
| `n` | `<leader>rx` | Disconnect / Stop remote session |
| `n` | `<leader>ri` | Show remote session details & info |

---

## 🔌 Included Plugins

| Plugin | Description |
| :--- | :--- |
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Modern plugin package manager |
| [nightfox.nvim](https://github.com/EdenEast/nightfox.nvim) | Carbonfox aesthetic color theme |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Quickstart configurations for the Nvim LSP client |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | Portable package manager for LSPs, DAP, and linters |
| [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) | Extension to mason.nvim that makes it easier to use lspconfig |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Completion engine with modular source backends |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine written in Lua |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Lightweight, fast formatter with format-on-save |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Nvim Treesitter configurations and abstraction layer |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Highly extendable fuzzy finder over lists |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer tree for Neovim |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | Snazzy buffer and tab line |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Fast and easy to configure Neovim statusline |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | Git decorations and hunks in the sign column |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | The premier Git wrapper for (Neo)vim |
| [remote-nvim.nvim](https://github.com/amitds1997/remote-nvim.nvim) | Remote development over SSH |
| [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim) | Visual indentation guides |
| [nvim-autopairs](https://github.com/windwp/nvim-autopairs) | Autopair plugin with Treesitter integration |
| [undotree](https://github.com/mbbill/undotree) | Visualizer for undo history branches |

---

## 🐳 DevOps Shell Aliases

A curated set of shell aliases is included in [`.bash_aliases`](file:///.bash_aliases) for terminal productivity:

- **Docker:** `d` (docker), `dps` (ps), `di` (images), `db` (build), `dr` (run), `dlog` (logs), `dex` (exec)
- **Kubernetes (Minikube):** `k` (`minikube kubectl`), `kgp` (get pods), `kgs` (get svc), `kgd` (get deployments), `kga` (get all)
- **Terraform:** `tf` (terraform), `tfi` (init), `tfp` (plan), `tfa` (apply), `tfd` (destroy), `tff` (fmt), `tfv` (validate)
- **Git:** `g` (git), `ga` (add .), `gc` (commit), `gcm` (commit -m), `gp` (push), `gpl` (pull), `gd` (diff), `gl` (graph log)

To load these in your shell:
```bash
# Add to ~/.bashrc or ~/.zshrc
source ~/.config/nvim/.bash_aliases
```

---

## 🔄 Maintenance & Updates

Keep your editor ecosystem up to date with these built-in commands:

```vim
" Sync and update plugins:
:Lazy sync

" Update Treesitter language parsers:
:TSUpdate

" Manage & update language servers and formatters:
:Mason
```

---

## 📜 License

This configuration is open-source software licensed under the [MIT License](https://opensource.org/licenses/MIT).
