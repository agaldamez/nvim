-- ~/.config/nvim/lua/plugins/diffview.lua
-- Diffview plugin configuration.
return {
  {
    "sindrets/diffview.nvim",
    config = function()
      require("diffview").setup()
    end,
  },
}
