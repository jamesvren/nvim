return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pylsp = { mason = false },
        clangd = { mason = false },
      },
    }
  }
}
