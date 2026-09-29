-- ~/.config/nvim/lua/plugins/advanced-git-search.lua
-- git log -S "<word>" on steroids!
return {
  {
    "aaronhallaert/advanced-git-search.nvim",
    cmd = { "AdvancedGitSearch" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      { "<leader>gs", "<cmd>AdvancedGitSearch<CR>", desc = "Advanced Git Search" },
    },
    config = function()
      require("telescope").load_extension("advanced_git_search")
    end,
  },
}
