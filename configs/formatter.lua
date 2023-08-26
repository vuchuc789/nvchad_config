-- Utilities for creating configurations
-- local util = require "formatter.util"

local augroup = vim.api.nvim_create_augroup("FormatAutogroup", {})
vim.api.nvim_clear_autocmds { group = augroup }
vim.api.nvim_create_autocmd("BufWritePost", {
  group = augroup,
  command = "FormatWrite",
})

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
require("formatter").setup {
  -- Enable or disable logging
  logging = true,
  -- Set the log level
  log_level = vim.log.levels.WARN,
  -- All formatter configurations are opt-in
  filetype = {
    lua = {
      require("formatter.filetypes.lua").stylua,
    },
    markdown = {
      require("formatter.filetypes.markdown").prettier,
    },
    json = {
      require("formatter.filetypes.json").prettier,
    },
    jsonc = {
      require("formatter.filetypes.json").prettier,
    },
    yaml = {
      require("formatter.filetypes.yaml").prettier,
    },
    python = {
      require("formatter.filetypes.python").black,
    },
    go = {
      require("formatter.filetypes.go").gofmt,
    },
    rust = {
      require("formatter.filetypes.rust").rustfmt,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    -- ["*"] = {
    -- "formatter.filetypes.any" defines default configurations for any
    -- filetype
    -- require("formatter.filetypes.any").remove_trailing_whitespace
    -- }
  },
}
