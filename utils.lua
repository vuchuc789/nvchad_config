local util = require "lspconfig.util"

local M = {}

M.detect_node_modules = function(path)
  return util.root_pattern "node_modules"(path)
end

M.detect_yarn_pnp = function(path)
  return util.root_pattern(".pnp.js", ".pnp.cjs")(path)
end

M.detect_venv = function(path)
  return util.root_pattern ".venv"(path)
end

return M
