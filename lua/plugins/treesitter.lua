--
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = { "markdown", "markdown_inline", "helm", "yaml" },
      highlight = { enable = true },
    },
    -- Apply opts: install listed parsers and enable modules (e.g. highlight).
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
