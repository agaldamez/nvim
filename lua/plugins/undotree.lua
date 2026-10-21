-- ~/.config/nvim/lua/plugins/undotree.lua
-- visualizer for Neovim's internal undo tree
return {
  {
    "jiaoshijie/undotree",
    opts = {
      window = {
        width = 0.15,
      },
    },
    keys = { -- load the plugin only when using it's keybinding:
      { "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
    },
    config = function(_, opts)
      require("undotree").setup(opts)

      -- tokyodark doesn't define diffAdded/diffRemoved (what undotree links to by
      -- default), so paint the float preview with the theme's Green/Red/Blue.
      local function set_diff_hl()
        vim.api.nvim_set_hl(0, "UndotreeDiffAdded", { link = "Green" })
        vim.api.nvim_set_hl(0, "UndotreeDiffRemoved", { link = "Red" })
        vim.api.nvim_set_hl(0, "UndotreeDiffLine", { link = "Blue" })
      end
      set_diff_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("undotree_diff_hl", { clear = true }),
        callback = set_diff_hl,
      })
    end,
  },
}
