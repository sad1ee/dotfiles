-- lua/plugins/rose-pine.lua
return {
  "rose-pine/neovim",
  enabled = false,
  name = "rose-pine",
  lazy = false,
  priority = 1000,
  opts = {
    variant = "moon",
    styles = {
      transparency = true,
    },
    highlight_groups = {
      TelescopeBorder = { fg = "highlight_high", bg = "none" },
      TelescopeNormal = { bg = "none" },
      TelescopePromptNormal = { bg = "base" },
      TelescopeResultsNormal = { fg = "subtle", bg = "none" },
      TelescopeSelection = { fg = "text", bg = "base" },
      TelescopeSelectionCaret = { fg = "rose", bg = "rose" },
    },
  },
}
