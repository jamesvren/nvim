return {
  "nvim-lualine/lualine.nvim",
  opts = function()
    local function fg(name)
      return function()
        ---@type {foreground?:number}?
        local hl = vim.api.nvim_get_hl_by_name(name, true)
        return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
      end
    end

    return {
      sections = {
        lualine_a = {
          { "mode" },
          { "location" },
        },
        -- lualine_b = { "branch" },
        lualine_c = {
          { "filename", path = 3 },
        },

        lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = fg("Statement")
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = fg("Constant"),
          },
          { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = fg("Special") },
        },
        lualine_y = { "progress" },
        lualine_z = { "datetime" },
      }
    }
  end,
}
