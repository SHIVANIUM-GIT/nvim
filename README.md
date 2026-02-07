Got it 👍
Your content is **good**, but the Markdown is **broken in a few places** (missing headings, code block not closed, section order).
Below is a **fully repaired, clean, GitHub-ready `README.md`**.

👉 You can **copy-paste this exactly** into `README.md`.

---

````md
# 🚀 Neovim Configuration (Lazy.nvim + Lua)

A modern, fast, and clean **Neovim configuration** built with **Lua** and **lazy.nvim**.  
Optimized for development, DevOps, and daily productivity.

---

## ✨ Features

- ⚡ Fast startup with `lazy.nvim`
- 🎨 Beautiful statusline using **lualine**
- 🔍 Fuzzy finding with **Telescope**
- 🌳 File explorer with **nvim-tree**
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
````

---

## 🧰 Requirements

### Neovim

```bash
nvim --version
```

✔ Recommended: **Neovim ≥ 0.9**

---

## 🔤 Nerd Font (IMPORTANT)

This configuration uses icons. You **must** install a Nerd Font.

### ✅ Recommended Font

**JetBrainsMono Nerd Font Mono**

---

### 📥 Install Nerd Font

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip JetBrainsMono.zip
fc-cache -fv
```

---

### 🔍 Verify Font Installation

```bash
fc-list | grep -i nerd
```

---

### 🖥 Set Font in Terminal

Set your terminal font to:

```
JetBrainsMono Nerd Font Mono
```

Then **restart your terminal**.

---

### 🧪 Font Test

```bash
echo "     "
```

If icons render correctly → Nerd Font is working ✅

---

## 📦 Install This Config

### Backup existing config (if any)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```

---

### Clone the repository

```bash
git clone https://github.com/SHIVANIUM-GIT/nvim.git ~/.config/nvim
```

---

### Start Neovim

```bash
nvim
```

`lazy.nvim` will automatically install all plugins 🎉

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

```text
lua/shiv/core/keymaps.lua
```

Leader key:

```text
<Space>
```

(Add your own custom mappings as needed.)

---

## ⚙️ Options

Editor options are defined in:

```text
lua/shiv/core/options.lua
```

Includes:

* 2-space indentation
* Relative line numbers
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
* Run the font test command

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

MIT

```

---

## ✅ What I fixed
- Closed all code blocks properly
- Restored missing section headers
- Fixed broken Markdown rendering
- Cleaned spacing & hierarchy
- GitHub-friendly formatting

If you want next:
- Add screenshots section
- Add keybinding table
- Add OS-specific install steps
- Add badges (stars, license, Neovim)

Just tell me 👌
```
