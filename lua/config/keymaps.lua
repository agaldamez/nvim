-- ~/.config/nvim/lua/config/keymaps.lua
-- Global / Neovim-specific key mappings (plugin maps live with the plugin).

local map = vim.keymap.set
local buffers = require("config.buffers")

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
