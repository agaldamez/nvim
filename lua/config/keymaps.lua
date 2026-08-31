-- ~/.config/nvim/lua/config/keymaps.lua
-- Global key mappings (plugin maps live in lua/plugins/).

local map = vim.keymap.set
local buffers = require("config.buffers")

-- Mouse (yank drag selection, clipboard paste, popup menu)
-- Drag release: yank and re-select (gv) so y/d/c still work. Visual ("x") only;
-- remap=true lets <LeftRelease> finalize before y runs.
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

-- Buffer quit (:q / :wq / :x via buffers.lua; ZZ / ZQ)
-- Close the current tab; exit Neovim if it was the last file.
buffers.setup()
map("n", "ZZ", function()
  buffers.quit({ write = true })
end, { desc = "Write and close buffer" })
map("n", "ZQ", function()
  buffers.quit({ bang = true })
end, { desc = "Close buffer (discard)" })

-- Window navigation (Ctrl-hjkl; useful with neo-tree open)
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to window below" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to window above" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Search
-- Neovim leaves search matches highlighted; Esc clears them.
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Buffers (<leader><leader> jumps to the previously edited buffer)
map("n", "<leader><leader>", "<C-^>", { desc = "Last buffer" })