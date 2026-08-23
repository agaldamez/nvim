-- ~/.config/nvim/lua/config/lazy.lua
-- Bootstraps lazy.nvim (clones it on first launch) and loads every plugin spec under lua/plugins/.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- `import = "plugins"` tells lazy to load every .lua file in lua/plugins/.
-- Each of those files returns a table of plugin specs.
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  checker = { enabled = false }, -- don't auto-check for updates; run :Lazy update manually
})
