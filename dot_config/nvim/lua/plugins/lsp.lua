return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        settings = {
          yaml = {
            keyOrdering = false,
            format = {
              enable = true,
              printWidth = 100,
              proseWrap = false,
            },
          },
        },
      },
    },
  },
}
