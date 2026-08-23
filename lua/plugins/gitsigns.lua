-- ~/.config/nvim/lua/plugins/gitsigns.lua
-- Gutter signs for added/changed/deleted lines, plus inline blame
return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- GitLens-style blame at end of line
      current_line_blame_opts = {
        delay = 500, -- default is 1000ms; blamer was closer to instant
      },
      -- default formatter already uses relative time:
      -- "Alice, 3 hours ago - commit message"
    },
  },
}
