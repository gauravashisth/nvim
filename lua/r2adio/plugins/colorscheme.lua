return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000, -- Ensure this loads early
	config = function()
		-- Define gruvbox settings in a table for clarity
		local gruvbox_settings = {
			terminal_colors = true, -- Enable Neovim terminal colors
			transparent_mode = true, -- Enable transparent background
			undercurl = true,
			underline = true,
			bold = true,
			italic = {
				strings = true,
				emphasis = true,
				comments = true,
				operators = false,
				folds = true,
			},
			strikethrough = true,
			invert_signs = false,
			invert_tabline = false,
			invert_intend_guides = false,
			contrast = "hard", -- Options: "hard", "soft", or ""
		}
		-- Apply gruvbox settings
		require("gruvbox").setup(gruvbox_settings)
		-- Set the colorscheme
		vim.cmd("colorscheme gruvbox")
	end,

	-- "rebelot/kanagawa.nvim",
	-- 	name = "kanagawa",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- Default options:
	-- 		require("kanagawa").setup({
	-- 			compile = true, -- enable compiling the colorscheme
	-- 			undercurl = true, -- enable undercurls
	-- 			commentStyle = { italic = true },
	-- 			functionStyle = {},
	-- 			keywordStyle = { italic = true },
	-- 			statementStyle = { bold = true },
	-- 			typeStyle = {},
	-- 			transparent = false, -- do not set background color
	-- 			dimInactive = false, -- dim inactive window `:h hl-NormalNC`
	-- 			terminalColors = true, -- define vim.g.terminal_color_{0,17}
	-- 			colors = { -- add/modify theme and palette colors
	-- 				palette = {},
	-- 				theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	-- 			},
	-- 			overrides = function(colors) -- add/modify highlights
	-- 				return {}
	-- 			end,
	-- 			theme = "wave", -- Load "wave" theme when 'background' option is not set
	-- 			background = { -- map the value of 'background' option to a theme
	-- 				dark = "dragon", -- try "dragon" !
	-- 				light = "lotus",
	-- 			},
	-- 			-- themes/background options: wave, dragon, lotus.
	-- 		})
	-- 		vim.cmd.colorscheme("kanagawa")
	-- 	end,
}
