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
  {
    "EdenEast/nightfox.nvim",
    enabled = false,
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd.colorscheme("nightfox")
    end,
  },
  {
    "tomasr/molokai",
    enabled = false,
    priority = 1000,
    lazy = false,
    config = function()
      vim.o.background = "dark"
      vim.cmd.colorscheme("molokai")
    end,
  },
}
