-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.maplocalleader = ","

vim.g.lazyvim_prettier_needs_config = true

vim.filetype.add({
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
    ["compose.yaml.j2"] = "yaml.docker-compose",
    ["compose.yml.j2"] = "yaml.docker-compose",
    ["include.yaml.j2"] = "yaml.docker-compose",
    ["include.yml.j2"] = "yaml.docker-compose",
  },
})

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

vim.filetype.add({
  extension = {
    gotmpl = "gotmpl",
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})
