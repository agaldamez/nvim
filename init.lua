-- ~/.config/nvim/init.lua
-- Entry point. Loads each module from lua/ via `require` (dots are folder
-- separators; `require("config.options")` loads lua/config/options.lua).

-- Leader key, set BEFORE plugins load so all plugin maps pick it up.
vim.g.mapleader = " "

require("config.options")   -- editor settings   (was `set ...`)
require("config.keymaps")   -- key mappings       (was `map ...`)
require("config.autocmds")  -- autocommands + diff colors
require("config.lazy")      -- bootstrap lazy.nvim + load everything in lua/plugins/
