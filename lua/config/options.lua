-- ~/.config/nvim/lua/config/options.lua
-- Editor settings (Lua equivalent of :set). See :help options and :help option-list.

local opt = vim.opt

-- Display
opt.background = "dark"     -- tell colorschemes to use their dark palette
opt.number = true           -- show absolute line numbers
opt.relativenumber = true   -- show relative line numbers
opt.linebreak = true        -- don't wrap in the middle of a word
opt.signcolumn = "yes"      -- keep the gutter stable (prevents text jump with gitsigns)
opt.showmode = false        -- lualine already shows the mode; avoid the extra `-- INSERT --`
opt.cursorline = true       -- highlight the current line

-- Indentation
opt.tabstop = 4             -- tabs display as 4 columns wide
opt.shiftwidth = 4          -- >>, <<, and auto-indent use 4 spaces
opt.expandtab = true        -- tabs insert spaces instead of tab character
opt.shiftround = true       -- >> and << snap indent to multiples of shiftwidth

-- Files / Persistence
opt.swapfile = false        -- no `*.swp` files
opt.undofile = true         -- persistent undo across sessions
opt.autoread = true         -- reload when the file changes on disk

-- Searching
opt.ignorecase = true       -- case-insensitive search by default
opt.smartcase = true        -- case-sensitive search once you type a capital letter

-- Cursor / Timing
opt.scrolloff = 8           -- keep context lines around the cursor
opt.sidescrolloff = 8       -- keep horizontal context on long lines
opt.updatetime = 250        -- faster CursorHold/gitsigns blame responsiveness
opt.timeoutlen = 400        -- faster leader key timeout (Space leader)

-- Editing behavior
opt.breakindent = true      -- preserve indent when lines wrap
opt.confirm = true          -- prompt before discarding edits on quit/close (:q, ZQ, etc.)

-- Window / statusline
opt.splitbelow = true       -- :split opens below the current window
opt.splitright = true       -- :vsplit opens to the right
opt.laststatus = 3          -- one global statusline (works well with lualine)

-- Clipboard
opt.clipboard = "unnamedplus,unnamed" -- yanks go to both "+ (CLIPBOARD) and "* (PRIMARY, for <MiddleMouse> paste)

-- Mouse
opt.mouse = "a"             -- Neovim owns the mouse; set "" to hand dragging back to tmux
opt.mousemodel = "extend"   -- right-click extends the selection instead of opening a popup menu

-- Colors
opt.termguicolors = true    -- 24-bit color (tokyodark + indent guides)

-- Diff
opt.diffopt:append("linematch:60") -- within-line matching makes vimdiff less noisy

-- netrw is disabled in favor of neo-tree (see lua/plugins/neo-tree.lua).
vim.g.loaded_netrw = 1        -- disable netrw (Neovim's built-in file explorer)
vim.g.loaded_netrwPlugin = 1  -- disable netrw's plugin/autocmd side (directory browsing)