-- ~/.config/nvim/lua/plugins/render-markdown.lua
return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown", -- load when markdown file is opened.
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}