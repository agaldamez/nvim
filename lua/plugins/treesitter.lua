-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter").install({
          "awk",
          "bash",
          "bpftrace",
          "diff",
          "dockerfile",
          "go",
          "gomod",
          "hcl",  -- hashicorp
          "helm",
          "html",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "perl",
          "python",
          "regex",
          "tcl",
          "terraform",
          "yaml",
      })

      -- Enable treesitter highlights for the current color scheme
      local function treesitter_highlights()
        local hl = vim.api.nvim_set_hl
        hl(0, "@variable", { link = "Identifier" })
        hl(0, "@variable.parameter", { link = "Identifier" })
        hl(0, "@variable.member", { link = "Identifier" })
        hl(0, "@module", { link = "Include" })
      end
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = treesitter_highlights,
      })
      treesitter_highlights()

      -- main no longer enables highlighting; Neovim does, per buffer.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if lang and vim.treesitter.language.add(lang) then
            vim.treesitter.start(ev.buf, lang)
          end
        end,
      })
    end,
  },
-- Jinja2: A standalone treesitter parser
  {
    "geigerzaehler/tree-sitter-jinja2",
    config = true,
  },
}
