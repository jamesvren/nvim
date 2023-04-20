return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      autoformat = false,
      servers = {
        lua_ls = { mason = false },
        jsonls = { mason = false },
        pylsp = { mason = false },
        clangd = { mason = false },
      },
    }
  }
}
