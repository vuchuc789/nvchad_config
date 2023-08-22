---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<leader>lf"] = {
      function()
        require("lint").try_lint()
      end,
      "Lint fix",
      opts = { silent = true },
    },
  },
  v = {
    [">"] = { ">gv", "Indent right", opts = { silent = true } },
    ["<"] = { "<gv", "Indent left", opts = { silent = true } },
  },
}

return M
