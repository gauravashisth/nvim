vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Copy indentation from the previous line
vim.opt.autoindent = true
-- Add `{` and `}` indentation rules
vim.opt.smartindent = true

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.spell = true
vim.opt.complete:append("s")

-- Change the color of line numbers
vim.cmd([[highlight LineNr guifg=#ADD8E6 guibg=#2E2E2E]])

-- fat cursor
vim.opt.guicursor = ""

-- Enable line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Disable Neovim's built-in mode display
vim.o.showmode = false

-- primeagen
-- yank in system clipboard
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y')
vim.keymap.set("x", "<leader>p", '"_dP', { noremap = true, silent = true })

-- to jump by half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- move the selected lines
--vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
--vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

-- give a menu, can start replacing the word was on.
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- make the script executable.
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.opt.scrolloff = 8

vim.opt.updatetime = 50
vim.opt.colorcolumn = "120"
