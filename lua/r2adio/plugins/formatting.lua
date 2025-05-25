return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				-- golang = { "golines" },
				go = { "goimports", "gofmt" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
			},
			-- format_on_save = {
			--   lsp_fallback = true,
			--   async = false,
			--   timeout_ms = 1000,
			-- },
		})

		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				require("conform").format({
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				})
			end,
		})
	end,
}
