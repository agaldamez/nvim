-- ~/.config/nvim/lua/config/options.lua

local opt = vim.opt

-- Display
opt.background = "dark"

opt.number = true
opt.relativenumber = true

opt.linebreak = true -- don't wrap in the middle of a word

opt.signcolumn = "yes" -- keep the gutter stable (prevents text jump with gitsigns)
opt.showmode = false   -- lualine already shows the mode; avoid the extra `-- INSERT --`
opt.cursorline = true  -- highlight the current line

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.shiftround = true -- >> and << snap indent to multiples of shiftwidth

-- Files / Persistence
opt.swapfile = false -- no `*.swp` files
opt.undofile = true  -- persistent undo across sessions

-- Searching
opt.ignorecase = true
opt.smartcase = true -- case-sensitive search once you type a capital

-- Cursor / Timing
opt.scrolloff = 8      -- keep context lines around the cursor
opt.sidescrolloff = 8  -- keep horizontal context on long lines
opt.updatetime = 250   -- faster CursorHold/gitsigns blame responsiveness
opt.timeoutlen = 400   -- faster leader key timeout (Space leader)

-- Editing behavior
opt.breakindent = true -- preserve indent when lines wrap
opt.confirm = true     -- ask before quitting unsaved buffers

-- Window / statusline
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- one global statusline (works well with lualine)

-- Clipboard
opt.clipboard = "unnamedplus" -- sync yanks with the system clipboard on Linux and macOS

-- Colors
opt.termguicolors = true -- 24-bit color (tokyodark + indent guides)
-- opt.mouse = "a"       -- Neovim already enables most mouse behavior; keep off unless you need it

-- Diff
opt.diffopt:append("linematch:60") -- within-line matching makes vimdiff less noisy

-- netrw is disabled in favor of neo-tree (see lua/plugins/neo-tree.lua).
vim.g.loaded_netrw = 1        -- disable netrw (Neovim's built-in file explorer)
vim.g.loaded_netrwPlugin = 1  -- disable netrw's plugin/autocmd side (directory browsing)
