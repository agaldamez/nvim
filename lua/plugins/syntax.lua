-- ~/.config/nvim/lua/plugins/syntax.lua
-- Filetype / syntax plugins. `ft` is Neovim's filetype (`:set filetype?`),
-- not the file extension. lazy.nvim still sources each plugin's ftdetect/
-- files at startup so detection can run; the rest of the plugin loads
-- only when that filetype is set.
return {
  {
    "Vimjas/vim-python-pep8-indent",
    ft = { "python", "cython" },
  },
  {
    "towolf/vim-helm",
    ft = { "helm", "yaml.helm-values" },
  },
  {
    "hashivim/vim-terraform",
    ft = { "terraform", "hcl" },
  },
  {
    "martinda/jenkinsfile-vim-syntax",
    ft = { "Jenkinsfile" },
  },
}
