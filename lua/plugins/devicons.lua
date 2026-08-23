-- Material-style file icons (fork of nvim-web-devicons).
-- Requires Nerd Font >= 3.2. Loads early so bufferline/lualine/neo-tree cache the right glyphs.
return {
  {
    "DaikyXendo/nvim-material-icon",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-web-devicons").setup({
        color_icons = true,
        default = true,
      })
    end,
  },
}
