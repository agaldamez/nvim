-- ~/.config/nvim/lua/config/autocmds.lua
-- Autocommands and startup visuals.

-- FileType indent: YAML, Helm, and Terraform conventionally use 2-space indents.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "yaml", "helm", "yaml.helm-values", "terraform", "hcl" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
  end,
})

-- Wipe leftover [No Name] (#) only when opening a real file, and only if still unnamed.
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local alt = vim.fn.bufnr("#")
    if alt > 0 and vim.api.nvim_buf_get_name(alt) == "" then
      pcall(vim.api.nvim_buf_delete, alt, { force = true })
    end
  end,
})