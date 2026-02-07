Nice repo 👍
I’ll give you a **ready-to-use `README.md`** that you can **copy-paste directly** into your GitHub repo.
It covers **everything**: install steps, Nerd Font, dependencies, structure, and usage.

You can tweak names later, but this is a **solid, professional README**.

---

# 🚀 Neovim Configuration (Lazy.nvim + Lua)

A modern, fast, and clean **Neovim configuration** built with **Lua** and **lazy.nvim**.  
Optimized for development, DevOps, and daily productivity.

---

## ✨ Features

- ⚡ Fast startup with `lazy.nvim`
- 🎨 Beautiful statusline using **lualine**
- 🔍 Fuzzy finding with Telescope
- 🌳 File explorer with nvim-tree
- 🧠 Clean Lua-based config structure
- 🔤 Nerd Font support (icons everywhere)

---

## 📸 Preview
> (Optional: add screenshots later)

---

## 📁 Directory Structure

```text
~/.config/nvim
├── init.lua
├── lazy-lock.json
└── lua/
    └── shiv/
        ├── core/
        │   ├── options.lua
        │   └── keymaps.lua
        └── plugins/
            ├── lazy.lua
            ├── lualine.lua
            ├── nvim-tree.lua
            └── telescope.lua

---

## 🧰 Requirements

### Neovim

```bash
nvim --version
```

✔ Recommended: **Neovim ≥ 0.9**

---

## 🔤 Nerd Font (IMPORTANT)

This config uses icons. You **must** install a Nerd Font.

### ✅ Recommended Font

**JetBrainsMono Nerd Font Mono**

### Install Nerd Font

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
```

### Verify Font

```bash
fc-list | grep -i nerd
```

### Set Font in Terminal

Set your terminal font to:

```
JetBrainsMono Nerd Font Mono
```

Restart terminal after setting.

---

## 🧪 Font Test

Run in terminal:

```bash
echo "     "
```

If icons render correctly → font is working ✅

---

## 📦 Install This Config

### Backup existing config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

### Clone the repo

```bash
git clone https://github.com/SHIVANIUM-GIT/nvim.git ~/.config/nvim
```

### Start Neovim

```bash
nvim
```

`lazy.nvim` will auto-install all plugins 🎉

---

## 🔌 Included Plugins

* **lazy.nvim** – Plugin manager
* **lualine.nvim** – Statusline
* **nvim-tree.lua** – File explorer
* **telescope.nvim** – Fuzzy finder
* **nvim-web-devicons** – Icons

---

## 📊 Statusline (lualine)

* Mode indicator
* Git branch & diff
* Diagnostics
* File name
* Cursor location

Uses Powerline-style separators (Nerd Font required).

---

## ⌨️ Keymaps

Keymaps are defined in:

```
lua/shiv/core/keymaps.lua
```

Leader key:

```
<Space>
```

(Add custom keymaps as needed)

---

## ⚙️ Options

Editor options are defined in:

```
lua/shiv/core/options.lua
```

Includes:

* 2-space indentation
* Relative numbers
* Smart search
* Better defaults

---

## 🔄 Update Plugins

Inside Neovim:

```vim
:Lazy sync
```

---

## 🧯 Troubleshooting

### Icons not showing?

* Ensure terminal font is **JetBrainsMono Nerd Font Mono**
* Restart terminal
* Run font test command

### Plugin errors?

```vim
:Lazy
:checkhealth
```

---

## 🙌 Credits

* Neovim community
* lazy.nvim
* Nerd Fonts

---

## 📜 License

MIT (or choose your own)

```

---

## ✅ What I can do next (optional)
- Customize README for **DevOps focus**
- Add screenshots section
- Add **keybindings table**
- Improve repo branding (badges, shields)
- Review your config file-by-file

If you want changes (shorter README, more advanced, screenshots, etc.), tell me your preference and I’ll refine it 👌
```
