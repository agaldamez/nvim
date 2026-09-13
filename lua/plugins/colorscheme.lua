-- ~/.config/nvim/lua/plugins/colorscheme.lua
return {
  {
    "tiagovla/tokyodark.nvim",
    enabled = true,
    priority = 1000,
    lazy = false,
    opts = {
      styles = {
        comments = { italic = false },
        keywords = { italic = false },
        identifiers = { italic = false },
        functions = {},
        variables = {},
      },
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd [[colorscheme tokyodark]]
    end,
  },
}
