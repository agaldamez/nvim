-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    cmd = "Telescope", -- load plugin on cmd line
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Telescope find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Telescope buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Telescope help tags" },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        -- extensions, defaults, pickers — optional
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = actions.close, -- close on first Esc press
            },
          },
        },
      })
    end,
  },
}
