-- ~/.config/nvim/lua/plugins/statusline.lua
-- A statusline with git status, file type, etc.
return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "DaikyXendo/nvim-material-icon" },
    opts = {}, -- defaults: theme = "auto", so it will follow tokyodark
  },
}