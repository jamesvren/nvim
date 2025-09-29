return {
  "neovim/nvim-lspconfig",

  opts = {
    servers = {
      rust_analyzer = {
        cmd = { "/root/.cargo/bin/rust-analyzer" },
      },
    },
  },
}
