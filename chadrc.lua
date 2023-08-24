---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

M.ui = {
  theme = "kanagawa",
  theme_toggle = { "kanagawa", "one_light" },

  hl_override = highlights.override,
  hl_add = highlights.add,
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

M.lazy_nvim = {
  performance = {
    rtp = {
      disabled_plugins = {
        -- "2html_plugin",
        -- "tohtml",
        -- "getscript",
        -- "getscriptPlugin",
        -- "gzip",
        -- "logipat",
        -- "netrw",
        -- "netrwPlugin",
        -- "netrwSettings",
        -- "netrwFileHandlers",
        -- "matchit",
        -- "tar",
        -- "tarPlugin",
        -- "rrhelper",
        -- "spellfile_plugin",
        -- "vimball",
        -- "vimballPlugin",
        -- "zip",
        -- "zipPlugin",
        -- "tutor",
        -- "rplugin",
        -- "syntax",
        -- "synmenu",
        -- "optwin",
        -- "compiler",
        -- "bugreport",
        -- "ftplugin",
      },
    },
  },
}

return M
