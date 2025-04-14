return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", function() vim.diagnostic.goto({ direction = "prev" }) end, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", function() vim.diagnostic.goto({ direction = "next" }) end, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			-- ["svelte"] = function()
			--   -- configure svelte server
			--   lspconfig["svelte"].setup({
			--     capabilities = capabilities,
			--     on_attach = function(client, bufnr)
			--       vim.api.nvim_create_autocmd("BufWritePost", {
			--         pattern = { "*.js", "*.ts" },
			--         callback = function(ctx)
			--           -- Here use ctx.match instead of ctx.file
			--           client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			--         end,
			--       })
			--     end,
			--   })
			-- end,
			["graphql"] = function()
				-- configure graphql language server
				lspconfig["graphql"].setup({
					capabilities = capabilities,
					filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
				})
			end,
			["emmet_ls"] = function()
				-- configure emmet language server
				lspconfig["emmet_ls"].setup({
					capabilities = capabilities,
					filetypes = {
						"html",
						"typescriptreact",
						"javascriptreact",
						"css",
						"sass",
						"scss",
						"less",
						"svelte",
					},
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
		})
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})
		-- require("lspconfig").pyright.setup({
		--   settings = {
		--     pyright = {
		--       -- Using Ruff's import organizer
		--       disableOrganizeImports = true,
		--     },
		--     python = {
		--       analysis = {
		--         typeCheckingMode = "basic", -- or "strict" for stricter checks
		--         diagnosticMode = "workspace", -- or "openFilesOnly"
		--         useLibraryCodeForTypes = true,
		--         autoSearchPaths = true,
		--         -- Add mypy-specific settings here
		--         mypy = {
		--           enabled = true,
		--           -- args = { "--ignore-missing-imports", "--follow-imports=silent", "--show-column-numbers" },
		--           args = { "--show-column-numbers" },
		--         },
		--       },
		--     },
		--   },
		-- })
		require("lspconfig").pylsp.setup({
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = {
							enabled = false,
							-- ignore = { "W391" },
							maxLineLength = 100,
						},
						pyflakes = { enabled = false },
						autopep8 = { enabled = false },
						yapf = { enabled = false },
						mccabe = { enabled = false },
						pylsp_mypy = { enabled = true },
						pylsp_black = { enabled = false },
						pylsp_isort = { enabled = false },
						rope = { enabled = true },
						rope_autoimport = { enabled = true },
					},
				},
			},
		})
		vim.diagnostic.config({
			-- virtual_text = true,
			virtual_text = { current_line = true },
			float = { border = "rounded" },
			update_in_insert = false,
			severity_sort = true,
		})

		-- require("lspconfig").ruff.setup({
		--   trace = "messages",
		--   init_options = {
		--     settings = {
		--       logLevel = "info",
		--       -- exclude = "**/tests/**",
		--       lineLength = 79,
		--       fixAll = true,
		--       organizeImports = true,
		--       showSyntaxErrors = true,
		--       codeAction = {
		--         disableRuleComment = {
		--           enable = true,
		--         },
		--         fixViolation = {
		--           enable = true,
		--         },
		--       },
		--       lint = {
		--         enable = true,
		--         preview = true,
		--         select = { "E", "F" },
		--         extendSelect = { "W" },
		--       },
		--       format = {
		--         preview = true,
		--       },
		--     },
		--   },
		-- })
	end,
}
