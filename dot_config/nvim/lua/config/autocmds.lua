-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = {
--     "*yml.j2",
--   },
--   command = "setlocal filetype=yaml.jinja",
-- })

-- vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = ".*%.yml%.j2",
--   command = "setlocal filetype=yaml.jinja",
-- })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*-docker%-compose%.yml%.j2",
    "docker%-compose*.yml%.j2",
    "*compose*.yml%.j2",
    "*.yml%.j2",
  },
  callback = function()
    vim.bo.filetype = "yaml.jinja"
  end,
})
