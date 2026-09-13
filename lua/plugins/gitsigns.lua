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
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function() -- Next hunk: ]c
          if vim.wo.diff then
            vim.cmd.normal({']c', bang = true})
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function() -- Previous hunk: [c
          if vim.wo.diff then
            vim.cmd.normal({'[c', bang = true})
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')

        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hR', gitsigns.reset_buffer)

        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hi', gitsigns.preview_hunk_inline)

        map('n', '<leader>hb', function() -- Full commit float: sha, message, author and date
          gitsigns.blame_line({ full = true })
        end)

        map('n', '<leader>hd', gitsigns.diffthis) -- Diff against the index: close with :only
        map('n', '<leader>hD', function()         -- Diff against HEAD~
          gitsigns.diffthis('~')
        end)

        -- Note: Use :cclose to close the quickfix list.
        -- Note: Snapshot only: press again to refresh after more edits. :copen to open view.
        map('n', '<leader>hQ', function() gitsigns.setqflist('all') end) -- Hunks in every modified file in the repo
        map('n', '<leader>hq', gitsigns.setqflist)                       -- Hunks in this buffer only

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame) -- Enable/disable: git blame at end of line
        map('n', '<leader>tw', gitsigns.toggle_word_diff)          -- Highlight word differences

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
      end,
    },
  },
}
