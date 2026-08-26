-- ~/.config/nvim/lua/plugins/bufferline.lua
-- Editor tabs for open buffers (VS Code-style). Offset so they sit over the
-- file window, not on top of neo-tree.
return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "DaikyXendo/nvim-material-icon" }, -- file-type icons on tabs
    lazy = false,
    keys = {
      { "<C-PageDown>", "<cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<C-PageUp>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous tab" },
    },
    opts = function()
      local bufferline = require("bufferline")
      local buffers = require("config.buffers")

      return {
        options = {
          style_preset = bufferline.style_preset.no_italic, -- no italics on the selected tab
          indicator = { style = "icon", icon = "▎" },       -- pink-ish bar on the left of the active tab
          show_buffer_close_icons = true,                   -- no "x" on each tab (right-click closes instead)
          show_close_icon = false,                          -- no "x" on the far right of the tabline
          close_command = buffers.close_tab,                -- what a close-icon click would run
          right_mouse_command = buffers.close_tab,          -- right-click a tab to close it
          max_name_length = 30,                             -- increase value to allow longer file names (default 18)
          offsets = {
            {
              filetype = "neo-tree",
              text = "Explorer", -- label in the gap above neo-tree
              highlight = "Directory",
              separator = true,
            },
          },
        },
      }
    end,
  },
}
