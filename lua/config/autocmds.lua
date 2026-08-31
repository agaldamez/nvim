-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocommands and startup visuals.

-- Diff mode highlights (vimdiff, :diffthis, merge tools)
-- Override tokyodark's Diff* groups and brighten comments while comparing files.
local diff_augroup = vim.api.nvim_create_augroup("ConfigDiff", { clear = true })

-- Set custom colors for added/changed/deleted lines and within-line changes.
local function setup_diff_highlights()
  vim.api.nvim_set_hl(0, "DiffAdd", { fg = "#A0A8CD", bg = "#1E2326" })
  vim.api.nvim_set_hl(0, "DiffChange", { fg = "#A0A8CD", bg = "#262B3D" })
  vim.api.nvim_set_hl(0, "DiffDelete", { fg = "#A0A8CD", bg = "#281B27" })
  vim.api.nvim_set_hl(0, "DiffText", { fg = "#D7A65F", bg = "#1C4474", bold = true })
end

-- tokyodark Comment (#4A5057) is too dim on diff backgrounds; skip when not diffing.
local function brighten_comments_for_diff()
  if not (vim.o.diff or vim.wo.diff) then
    return
  end
  vim.api.nvim_set_hl(0, "Comment", { fg = "#A0A8CD", italic = false })
end

-- Apply diff highlights and, when in diff mode, the brighter Comment override.
local function apply_diff_visuals()
  setup_diff_highlights()
  brighten_comments_for_diff()
end

-- Reload the full theme so Comment and other groups reset after :diffoff.
local function restore_theme()
  vim.cmd.colorscheme("tokyodark")
  setup_diff_highlights()
end

-- Re-apply after tokyodark loads and once at startup.
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  group = diff_augroup,
  callback = apply_diff_visuals,
})

-- Entering diff mode → apply visuals; leaving → restore the normal theme.
vim.api.nvim_create_autocmd("OptionSet", {
  group = diff_augroup,
  pattern = "diff",
  callback = function()
    if vim.v.option_new == "1" then
      apply_diff_visuals()
    else
      restore_theme()
    end
  end,
})

-- FileType indent: YAML, Helm, and Terraform conventionally use 2-space indents.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "helm", "yaml.helm-values", "terraform", "hcl" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})