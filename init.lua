-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.

require("bootstrap")

require("settings")

require("numline")

require("lazy").setup("plugins")

local ftplugin_path = "ftplugin." -- Base module path

vim.diagnostic.config({
	virtual_text = true, -- Show inline error messages
	float = { border = "rounded" }, -- Ensure floating diagnostics are shown
	update_in_insert = false,
	severity_sort = true, -- Sort diagnostics by severity
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local module = ftplugin_path .. args.match
		local ok, _ = pcall(require, module)
		if not ok then
			-- If no specific configuration exists, silently ignore
			-- Uncomment the line below for debugging purposes
			-- print("No configuration for filetype: " .. args.match)
		end
	end,
})

--highlight when yanking text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking test",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = { ".env", "wrangler.toml", ".dev.vars" },
	callback = function()
		vim.cmd("CloakEnable")
	end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })

--to change the color for telescope window
vim.cmd([[
  highlight TelescopeNormal guibg=#000000
  highlight TelescopeBorder guibg=#000000
  highlight TelescopePromptNormal guibg=#000000
  highlight TelescopePromptBorder guibg=#000000
  highlight TelescopePreviewNormal guibg=#000000
  highlight TelescopePreviewBorder guibg=#000000
]])
--changes the color of selected text
vim.cmd([[ highlight Visual guibg=#293241 ]])

--as rose pine doesnot
vim.cmd("highlight EndOfBuffer guifg=bg guibg=bg") -- Make EOB match background

-- autocomplete
vim.opt.matchpairs:append({ "(:)", "{:}", "[:]" })
vim.api.nvim_set_keymap("i", "(", "()<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "{", "{}<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "[", "[]<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", '"', '""<Left>', { noremap = true })
vim.api.nvim_set_keymap("i", "'", "''<Left>", { noremap = true })
vim.api.nvim_set_keymap("i", "`", "``<Left>", { noremap = true })
