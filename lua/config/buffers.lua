-- Shared buffer close / quit helpers.
-- Right-click (bufferline), ZZ/ZQ, and :q/:wq/:x all use this module.

local M = {}

-- Close a buffer without destroying the split next to neo-tree.
-- :bdelete on the *current* buffer also closes that window, which would
-- leave only the explorer (full width) while other tabs still exist.
-- `bdelete!` discards unsaved edits; the tab's modified marker is the warning.
function M.close_tab(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()

  -- Another listed *named* file we can show in this window instead.
  local replacement
  for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if buf.bufnr ~= bufnr
      and vim.bo[buf.bufnr].filetype ~= "neo-tree"
      and vim.api.nvim_buf_get_name(buf.bufnr) ~= ""
    then
      replacement = buf.bufnr
      break
    end
  end

  if replacement then
    -- Keep the file pane: swap in another buffer, then delete this one.
    for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
      vim.api.nvim_win_set_buf(win, replacement)
    end
    vim.cmd("bdelete! " .. bufnr)
  else
    -- Last file: close the file pane first so :bdelete cannot fill it
    -- with a blank [No Name]. What's left is neo-tree, full width.
    for _, win in ipairs(vim.fn.win_findbuf(bufnr)) do
      if #vim.api.nvim_tabpage_list_wins(0) > 1 then
        vim.api.nvim_win_close(win, false)
      end
    end
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.cmd("bdelete! " .. bufnr)
    end
    vim.cmd("Neotree show")
  end
end

local function file_buffer_count()
  local n = 0
  for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
    if vim.bo[buf.bufnr].filetype ~= "neo-tree"
      and vim.api.nvim_buf_get_name(buf.bufnr) ~= ""
    then
      n = n + 1
    end
  end
  return n
end

-- write=true  → like ZZ / :wq / :x
-- bang=true   → like ZQ / :q!
function M.quit(opts)
  opts = opts or {}
  local bufnr = vim.api.nvim_get_current_buf()

  -- In neo-tree: keep normal quit (close that window / leave).
  if vim.bo[bufnr].filetype == "neo-tree" then
    vim.cmd(opts.bang and "quit!" or "quit")
    return
  end

  if opts.write then
    vim.cmd("update") -- write only if modified
  elseif vim.bo[bufnr].modified and not opts.bang then
    vim.notify("No write since last change (add ! to override)", vim.log.levels.ERROR)
    return
  end

  M.close_tab(bufnr)

  -- Last file tab → leave Neovim (edit → save/quit → done).
  if file_buffer_count() == 0 then
    vim.cmd(opts.bang and "qa!" or "qa")
  end
end

function M.setup()
  vim.api.nvim_create_user_command("Q", function(o)
    M.quit({ bang = o.bang })
  end, { bang = true })

  vim.api.nvim_create_user_command("Wq", function(o)
    M.quit({ write = true, bang = o.bang })
  end, { bang = true })

  vim.api.nvim_create_user_command("X", function(o)
    M.quit({ write = true, bang = o.bang })
  end, { bang = true })

  -- Only replace plain :q / :wq / :x — leave :qa / :wqa alone.
  vim.cmd([[cnoreabbrev <expr> q  (getcmdtype() == ':' && getcmdline() == 'q')  ? 'Q'  : 'q']])
  vim.cmd([[cnoreabbrev <expr> q! (getcmdtype() == ':' && getcmdline() == 'q!') ? 'Q!' : 'q!']])
  vim.cmd([[cnoreabbrev <expr> wq (getcmdtype() == ':' && getcmdline() == 'wq') ? 'Wq' : 'wq']])
  vim.cmd([[cnoreabbrev <expr> wq! (getcmdtype() == ':' && getcmdline() == 'wq!') ? 'Wq!' : 'wq!']])
  vim.cmd([[cnoreabbrev <expr> x  (getcmdtype() == ':' && getcmdline() == 'x')  ? 'X'  : 'x']])
  vim.cmd([[cnoreabbrev <expr> x! (getcmdtype() == ':' && getcmdline() == 'x!') ? 'X!' : 'x!']])
end

return M
