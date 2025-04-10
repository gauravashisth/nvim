return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"debugloop/telescope-undo.nvim",
		},

		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")

			telescope.setup({
				extensions = {
					fzf = {},
					undo = {
						use_delta = true,
						side_by_side = true,
						layout_strategy = "vertical",
						layout_config = { preview_height = 0.7 },
						mappings = {
							i = {
								["<cr>"] = require("telescope-undo.actions").yank_additions,
								["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
								["<C-cr>"] = require("telescope-undo.actions").restore,
								-- alternative defaults, for users whose terminals do questionable things with modified <cr>
								["<C-y>"] = require("telescope-undo.actions").yank_deletions,
								["<C-r>"] = require("telescope-undo.actions").restore,
							},
							n = {
								["y"] = require("telescope-undo.actions").yank_additions,
								["Y"] = require("telescope-undo.actions").yank_deletions,
								["u"] = require("telescope-undo.actions").restore,
							},
						},
					},
				},
				pickers = { undo = { initial_mode = "normal" } },
			})
			telescope.load_extension("fzf")
			telescope.load_extension("undo")

			-- Optionally load Telescope extensions (if any are installed)
			-- require('telescope').load_extension('fzf')
			-- Keybindings to launch Telescope
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
			vim.keymap.set(
				"n",
				"<leader>fh",
				"<cmd>lua require('telescope.builtin').find_files({ hidden = true })<CR>",
				{ desc = "Find files (include hidden)" }
			)
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "List Buffers" })
			vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "List Buffers" })
			vim.keymap.set("n", "<leader>ws", builtin.lsp_workspace_symbols, { desc = "List Buffers" })
			-- Buffer navigation
			vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next Buffer" })
			vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous Buffer" })
			-- Delete buffer
			vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })
			--undo history
			vim.keymap.set("n", "<leader>fu", ":Telescope undo<CR>", { desc = "Undo History" })
			--to search from help menu
			vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>", { desc = "keymaps" })
			--jump to config
			vim.keymap.set("n", "<leader>fc", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					layout_config = {
						height = 0.9, -- Adjusts the overall height
						preview_height = 0.65, -- Adjusts the height of the preview section
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				pickers = {
					buffers = {
						initial_mode = "normal",
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
