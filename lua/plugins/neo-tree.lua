-- ~/.config/nvim/lua/plugins/neo-tree.lua
-- File explorer (replaces netrw / NERDTree).
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "DaikyXendo/nvim-material-icon",
    },
    lazy = false, -- load at startup so it's ready when you open a file.
    opts = {
      filesystem = {
        bind_to_cwd = false, -- don't re-root the tree when you close/switch buffers
      },
      default_component_configs = {
        git_status = {
          symbols = false, -- ASCII codes like [M ] / [ M] instead of nerd-font glyphs
        },
      },
    },
    keys = {
      { "<leader>n", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
      { "<C-n>", "<cmd>Neotree toggle<CR>", desc = "Toggle file explorer" },
    },
    -- Open the explorer automatically when nvim starts with no file argument.
    -- The StdinReadPre guard avoids popping the sidebar when you pipe text in
    -- (e.g. `cat file | nvim -`).
    init = function()
      local std_in = false
      vim.api.nvim_create_autocmd("StdinReadPre", {
        callback = function() std_in = true end,
      })
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.argc() == 0 and not std_in then
            vim.cmd("Neotree")
          end
        end,
      })
    end,
  }
}
