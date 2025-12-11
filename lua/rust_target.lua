local M = {}

-- The two targets you want to switch between
local WIN_TARGET = "x86_64-pc-windows-gnu"
local LINUX_TARGET = "x86_64-unknown-linux-gnu"

-- Current target state
M.current = "linux" -- Default to Linux

-- Apply rust-analyzer settings dynamically
local function apply_target(target)
  local lspconfig = require("lspconfig")

  -- Setup rust-analyzer with the new target
  lspconfig.rust_analyzer.setup({
    settings = {
      ["rust-analyzer"] = {
        cargo = { target = target },
        -- checkOnSave = {
        --   command = "clippy",
        --   extraArgs = { "--target", target },
        -- },
        -- procMacro = { enable = true },
      },
    },
  })

  vim.notify("Rust target set to: " .. target, vim.log.levels.INFO)

  -- Restart rust-analyzer to apply changes
  vim.cmd("LspRestart rust_analyzer")
end

-- Set target to Windows
function M.set_windows()
  M.current = "windows"
  apply_target(WIN_TARGET)
end

-- Set target to Linux
function M.set_linux()
  M.current = "linux"
  apply_target(LINUX_TARGET)
end

-- Toggle between targets
function M.toggle()
  if M.current == "linux" then
    M.set_windows()
  else
    M.set_linux()
  end
end

-- Open a floating window for target selection
function M.select_target()
  local options = {
    { label = "1: Windows (x86_64-pc-windows-gnu)", command = M.set_windows },
    { label = "2: Linux (x86_64-unknown-linux-gnu)", command = M.set_linux },
  }

  -- Use inputlist for selection
  local choice = vim.fn.inputlist(vim.tbl_map(function(opt)
    return opt.label
  end, options))

  if choice > 0 and choice <= #options then
    options[choice].command()
  else
    vim.notify("Invalid choice", vim.log.levels.ERROR)
  end
end

return M
