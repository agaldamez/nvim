-- ~/.config/nvim/lua/plugins/undotree.lua
-- visualizer for Neovim's internal undo tree
return {
  {
    "jiaoshijie/undotree",
    opts = {
      -- default settings
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
  },
}
