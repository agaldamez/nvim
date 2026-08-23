-- ~/.config/nvim/lua/plugins/indent-blankline.lua
-- Indent guides (replaces vim-indent-guides). `main = "ibl"` is required
-- because the Lua module is named `ibl`, not `indent-blankline`.
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- Dim bar only; no column fill.
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#4A5057" })
      end)

      require("ibl").setup({
        indent = {
          char = "▏", -- thinner than the default "▎"
          smart_indent_cap = false, -- draw a bar even when indent is extra-deep
        },
        scope = { enabled = false }, -- only indent bars, not “current block”
      })
    end,
  },
}
