require("r2adio.core.options")
require("r2adio.core.keymaps")

-- Hyprlang LSP
-- vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
--   pattern = { "*.hl", "hypr*.conf" },
--   callback = function(event)
--     print(string.format("starting hyprls for %s", vim.inspect(event)))
--     vim.lsp.start({
--       name = "hyprlang",
--       cmd = { "hyprls" },
--       root_dir = vim.fn.getcwd(),
--     })
--   end,
-- })
