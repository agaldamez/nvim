-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocommands and startup visuals.

-- ---------------------------------------------------------------------------
-- vimdiff highlights (tokyodark palette)
-- Must run after the colorscheme loads — init.lua requires this file before
-- lazy.nvim, so tokyodark would overwrite any highlights set here at startup.
-- ColorScheme + VimEnter re-apply them; Comment is brightened only while diffing.
-- ---------------------------------------------------------------------------
local function setup_diff_highlights()
  vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#A0A8CD", bg = "#1E2326" })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = "#A0A8CD", bg = "#262B3D" })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#A0A8CD", bg = "#281B27" })
  -- Changed words within a line: yellow on blue so they stand out from comments.
  vim.api.nvim_set_hl(0, "DiffText", { fg = "#D7A65F", bg = "#1C4474", bold = true })
end

local function brighten_comments_for_diff()
  if not (vim.o.diff or vim.wo.diff) then
    return
  end
  -- tokyodark Comment is #4A5057 — too dim on diff backgrounds.
  vim.api.nvim_set_hl(0, "Comment", { fg = "#A0A8CD", italic = false })
end

local function restore_theme()
  vim.cmd.colorscheme("tokyodark")
  setup_diff_highlights()
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    setup_diff_highlights()
    brighten_comments_for_diff()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    setup_diff_highlights()
    brighten_comments_for_diff()
  end,
})

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "diff",
  callback = function()
    if vim.v.option_new == "1" then
      setup_diff_highlights()
      brighten_comments_for_diff()
    else
      restore_theme()
    end
  end,
})

-- ---------------------------------------------------------------------------
-- Indentation tweaks for common formats
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "helm", "yaml.helm-values", "terraform", "hcl" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})
