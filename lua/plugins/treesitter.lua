-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
          "bash",
          "diff",
          "dockerfile",
          "go",
          "gomod",
          "hcl",  -- hashicorp
          "helm",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "tcl",
          "terraform",
          "yaml",
      },
      highlight = { enable = true },
    },
    -- Apply opts: install listed parsers and enable modules (e.g. highlight).
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
