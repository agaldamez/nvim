-- ~/.config/nvim/lua/config/terminal.lua
-- Toggleable terminal split under the current editor window
-- <leader>` opens/closes it. Closing the split keeps the shell; `exit` / <C-d> kills it.
-- <C-w>z toggles maximize height / equalize window sizes.

-- Remember our toggle terminal so reopen reuses the same shell (nil until first open).
local term_bufnr ---@type integer?

-- Check whether a window is showing a :terminal buffer (used when closing the toggle).
local function is_terminal_win(win)
  local buf = vim.api.nvim_win_get_buf(win)
  return vim.bo[buf].buftype == "terminal"
end

-- Close the terminal split if it is visible in this tab. Returns true if closed.
local function close_terminal_split()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if is_terminal_win(win) then
      -- Close the window only; the shell job and scrollback stay in term_bufnr.
      vim.api.nvim_win_close(win, true)
      return true
    end
  end
  return false
end

-- Open a split of the *current* window (same as :split | terminal).
-- Reuses the existing shell when possible so history survives toggles.
local function open_terminal_split()
  if term_bufnr and vim.api.nvim_buf_is_valid(term_bufnr) then
    vim.cmd("split")
    vim.api.nvim_win_set_buf(0, term_bufnr)
  else
    vim.cmd("split | terminal")
    term_bufnr = vim.api.nvim_get_current_buf()
  end

  -- Hide from bufferline / :ls (still visible with :ls!).
  vim.bo[term_bufnr].buflisted = false
  vim.cmd("startinsert")
end

-- Toggle: close if open, otherwise open under the focused editor window.
vim.keymap.set({ "n", "t" }, "<leader>`", function()
  if not close_terminal_split() then
    open_terminal_split()
  end
end, { desc = "Toggle terminal under current window" })

-- Toggle maximize height / equalize (works from normal and terminal mode).
local maximized = false
vim.keymap.set({ "n", "t" }, "<C-w>z", function()
  if vim.fn.mode() == "t" then
    vim.cmd("stopinsert")
  end
  if maximized then
    vim.cmd("wincmd =") -- equalize
  else
    vim.cmd("wincmd _") -- maximize height
  end
  maximized = not maximized
  if vim.bo.buftype == "terminal" then
    vim.cmd("startinsert")
  end
end, { desc = "Toggle maximize / equalize windows" })

-- Focus (click or <C-hjkl>) always enters terminal insert mode.
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})