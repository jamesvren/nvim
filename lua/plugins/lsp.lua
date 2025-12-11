return {
  "neovim/nvim-lspconfig",

  opts = {
    servers = {
      rust_analyzer = {
        cmd = { "/root/.cargo/bin/rust-analyzer" },
        -- settings = {
        --   ["rust-analyzer"] = {
        --     cargo = { target = "x86_64-unknown-linux-gnu" }, -- Default to Linux
        --     procMacro = { enable = true },
        --     checkOnSave = {
        --       command = "clippy",
        --       extraArgs = { "--target", "x86_64-unknown-linux-gnu" },
        --     },
        --   },
        -- },
      },
    },
  },

  config = function()
    local lspconfig = require("lspconfig")
    local rust_target = require("rust_target")

    -- Setup rust-analyzer LSP with initial target settings (default to Linux)
    lspconfig.rust_analyzer.setup({
      -- settings = {
      --   ["rust-analyzer"] = {
      --     cargo = { target = "x86_64-unknown-linux-gnu" }, -- Default target is Linux
      --     procMacro = { enable = true },
      --     checkOnSave = {
      --       command = "clippy",
      --       extraArgs = { "--target", "x86_64-unknown-linux-gnu" },
      --     },
      --   },
      -- },
    })

    -- Create custom commands
    vim.api.nvim_create_user_command("RustTargetWindows", rust_target.set_windows, {})
    vim.api.nvim_create_user_command("RustTargetLinux", rust_target.set_linux, {})
    vim.api.nvim_create_user_command("RustTargetToggle", rust_target.toggle, {})
    vim.api.nvim_create_user_command("RustTargetSelect", rust_target.select_target, {})

    vim.api.nvim_set_keymap("n", "<leader>rw", ":RustTargetWindows<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>rl", ":RustTargetLinux<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "<leader>rt", ":RustTargetToggle<CR>", { noremap = true, silent = true })
  end,
}
