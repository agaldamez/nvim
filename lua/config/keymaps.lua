-- ~/.config/nvim/lua/config/keymaps.lua
-- Global / Neovim-specific key mappings (plugin maps live with the plugin).

local map = vim.keymap.set
local buffers = require("config.buffers")

-- Mouse release: yank the selection, then `gv` re-selects it so y/d/c/> still apply.
-- `remap = true` is required and safe: a {rhs} starting with its own {lhs} does not
-- recurse (see `:h recursive_mapping`), so the leading <LeftRelease> reaches Neovim
-- and finalizes the drag before `y` runs.
-- Mode is "x" (Visual only), not "v" ("v" also covers Select mode, where a bare
-- `y` would replace the selection with the literal character).
map("x", "<LeftRelease>", "<LeftRelease>ygv", {
  remap = true,
  desc = "Yank mouse selection, keep it selected",
})

-- Right-click pastes "+ (CLIPBOARD), i.e. whatever Ctrl-C in another app put there.
-- Middle-click is left built-in: it pastes "* (PRIMARY), the last mouse selection.
-- The <LeftMouse> prefix moves the cursor to the click position first.
map("n", "<RightMouse>", '<LeftMouse>"+gP', { desc = "Paste system clipboard at click" })
map("i", "<RightMouse>", "<LeftMouse><C-r><C-o>+", { desc = "Paste system clipboard at click" })
-- Under mousemodel=extend a bare <RightRelease> extends the selection, which would
-- drop us into Visual mode right after the paste.
map({ "n", "i" }, "<RightRelease>", "<Nop>", { desc = "Ignore right-click release" })

-- Right-click no longer opens Neovim's own menu (Inspect, gx, Select All), so reach
-- it from the keyboard instead. No `!` on :popup, so it opens at the cursor.
map({ "n", "x" }, "<leader>m", "<Cmd>popup PopUp<CR>", { desc = "Open Neovim's right-click menu" })

buffers.setup() -- :q / :wq / :x → close tab (see config/buffers.lua)

-- Move between splits with Ctrl plus hjkl (same as Ctrl-w then h/j/k/l).
-- Useful with neo-tree open on the left.
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Neovim leaves search matches highlighted; Esc clears them.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- ZZ ≈ :wq  |  ZQ ≈ :q!  — close the current tab; exit Neovim if it was the last file.
map("n", "ZZ", function()
  buffers.quit({ write = true })
end, { desc = "Write and close buffer" })

map("n", "ZQ", function()
  buffers.quit({ bang = true })
end, { desc = "Close buffer (discard)" })

-- Jump to the previously edited buffer. Space then Space. Same idea as Ctrl-^.
map("n", "<leader><leader>", "<C-^>", { desc = "Last buffer" })
