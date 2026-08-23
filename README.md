# Neovim config dependencies

Plugins are installed automatically by [lazy.nvim](https://github.com/folke/lazy.nvim) on first launch. What you need on the **host** is listed below.

## Required

| Dependency | Why |
| --- | --- |
| [Neovim](https://neovim.io/) 0.11+ | This config is Lua-only (`init.lua`). Tested on 0.11.6. |
| [Git](https://git-scm.com/) | lazy.nvim clones plugins; [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) and neo-tree git status need it. |
| A [Nerd Font](https://www.nerdfonts.com/) **≥ 3.2** | [nvim-material-icon](https://github.com/DaikyXendo/nvim-material-icon) (file icons in neo-tree, bufferline, and lualine). Older fonts show boxes, especially on YAML. |

**Fedora:**

```bash
sudo dnf install neovim git
```

**macOS** ([Homebrew](https://brew.sh/)):

```bash
brew install neovim git
```

Confirm with `nvim --version` (needs 0.11+).

### Nerd Font

1. Download a patched font (for example JetBrainsMono Nerd Font) from [nerdfonts.com/font-downloads](https://www.nerdfonts.com/font-downloads). Distro packages are often older than 3.2.
2. Install it:

   **Fedora:**

   ```bash
   mkdir -p ~/.local/share/fonts
   unzip JetBrainsMono.zip -d ~/.local/share/fonts/JetBrainsMonoNerd
   fc-cache -fv
   ```

   **macOS** (either Homebrew, or unzip a download into `~/Library/Fonts`):

   ```bash
   brew install --cask font-jetbrains-mono-nerd-font
   # or: unzip JetBrainsMono.zip -d ~/Library/Fonts
   ```

3. Fully restart the terminal so it reloads fonts. GNOME Terminal and macOS Terminal/iTerm often pick up new glyphs without changing the profile font.
4. If icons are still boxes, set the Nerd Font in the terminal profile (not in Neovim).

Confirm glyphs with `:NvimWebDeviconsHiTest` inside Neovim.

## Recommended

| Dependency | Why |
| --- | --- |
| A truecolor terminal | `termguicolors` is on; tokyodark and indent guides need 24-bit color. |
| Clipboard tool | `clipboard = "unnamedplus"` syncs yanks with the system clipboard. |

**Clipboard on Fedora:**

```bash
# Wayland
sudo dnf install wl-clipboard

# X11
sudo dnf install xclip
```

**Clipboard on macOS:** nothing to install. Neovim uses the built-in `pbcopy` / `pbpaste` providers, so `unnamedplus` talks to the system clipboard already.

`:checkhealth` reports whether Neovim found a clipboard provider.

## First launch

From this directory (or after copying it to `~/.config/nvim`):

```bash
nvim
```

lazy.nvim clones itself, then installs everything in `lua/plugins/` (locked by `lazy-lock.json`). Run `:Lazy` to inspect plugins, `:Lazy sync` to install or update.

## Keymaps

`<leader>` is Space.

| Keys | Action |
| --- | --- |
| `<leader>n` / `<C-n>` | Toggle file explorer (neo-tree) |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Move to left / below / above / right window (including neo-tree) |
| `<leader><leader>` | Jump to last buffer |
| `<Esc>` | Clear search highlights |
| `<C-PageUp>` / `<C-PageDown>` | Previous / next tab |
| `ZZ` / `:wq` / `:x` | Write (if needed) and close current tab; exit Neovim if it was the last file |
| `ZQ` / `:q!` | Close current tab (discard changes); exit Neovim if it was the last file |
| `:q` | Close current tab if saved; exit Neovim if it was the last file |

Right-click a tab closes that buffer only (keeps Neovim open). `:qa` / `:wqa` still quit Neovim entirely.

## Health checks

After install or when something looks wrong:

```text
:checkhealth
:checkhealth lazy
:checkhealth gitsigns
```

`:checkhealth` covers clipboard providers. Confirm icons with `:NvimWebDeviconsHiTest`.

## Plugins that pull extra icons/fonts

These UI plugins all use nvim-material-icon, so they share the Nerd Font requirement:

- neo-tree (file explorer)
- bufferline (tabs)
- lualine (statusline)

indent-blankline uses the Unicode bar `▏`. That character is in most modern monospace fonts; a Nerd Font still covers it.
