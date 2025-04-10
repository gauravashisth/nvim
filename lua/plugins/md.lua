return {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		event = {
			"BufReadPre " .. vim.fn.expand("~/notes") .. "/*.md",
			"BufNewFile " .. vim.fn.expand("~/notes") .. "/*.md",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		opts = {
			workspaces = {
				{
					name = "notes",
					path = "~/notes",
				},
			},
			ui = { enable = false }, -- Disables Obsidian’s additional UI features
			disable_frontmatter = true, -- Enable frontmatter parsing
			new_notes_location = "notes_subdir", -- Customize where new notes go
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = true,
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
		---@module 'render-markdown'
		-- ---@type render.md.UserConfig
		---@type table
		opts = {
			conceal = true, -- Hides markdown syntax elements
			theme = "dark", -- Adjusts styling (options: 'dark', 'light', 'auto')
		},
	},
}
