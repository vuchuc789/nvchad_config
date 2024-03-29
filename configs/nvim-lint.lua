vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require("lint").linters_by_ft = {
  proto = { "buf_lint" },
  dockerfile = { "hadolint" },
}
