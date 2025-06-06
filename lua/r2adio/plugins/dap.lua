return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"leoluz/nvim-dap-go",
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim", -- Add mason-nvim-dap
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			dap.adapters.cppdbg = {
				id = "cppdbg",
				type = "executable",
				command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
			}
			dap.configurations.cpp = {
				{
					name = "Launch file",
					type = "cppdbg",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
					setupCommands = {
						{
							text = "-enable-pretty-printing",
							description = "enable pretty printing",
							ignoreFailures = false,
						},
					},
				},
			}
			dap.configurations.c = dap.configurations.cpp

			require("dapui").setup()
			require("dap-go").setup()

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set("n", "<Leader>dt", ":DapUiToggle<CR>", {})
			vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {})
			vim.keymap.set("n", "<Leader>dc", dap.continue, {})
			vim.keymap.set("n", "<Leader>dr", ":lua require('dapui').open({reset = true})<CR>", {})
			vim.keymap.set("n", "<Leader>dn", dap.step_over, {})
			vim.keymap.set("n", "<Leader>di", dap.step_into, {})
			vim.keymap.set("n", "<Leader>do", dap.step_out, {})
			vim.keymap.set("n", "<Leader>dq", dap.terminate, {})

			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "⏺", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint" }
			)
		end,
	},
	{
		-- "mfussenegger/nvim-dap-python",
		-- ft = "python",
		-- dependencies = {
		-- 	"mfussenegger/nvim-dap",
		-- },
		-- config = function(_, opts)
		-- 	local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python3"
		-- 	require("dap-python").setup(path)
		-- 	-- require("core.utils").load_mappings("dap_python")
		-- end,
	},
}
