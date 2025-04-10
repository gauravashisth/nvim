return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim", -- Add mason-nvim-dap
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      ensure_installed = { "codelldb" }, -- Auto-install CodeLLDB
      -- ensure_installed = { "codelldb", "delve", "debugpy", "js-debug-adapter" },
      -- run :MasonInstall codelldb delve debugpy js-debug-adapter
      automatic_setup = true,
    })

    dap.adapters.codelldb = {
      type = "server",
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
        args = { "--port", "${port}" },
      },
    }
    -- Debug configuration for C and C++
    dap.configurations.cpp = {
      {
        name = "Launch C++ with CodeLLDB",
        type = "codelldb",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }
    dap.configurations.c = dap.configurations.cpp

    -- Debug configuration for Rust
    dap.configurations.rust = dap.configurations.cpp

    --[[
		-- 🐍 Python Debugging
		dap.adapters.python = {
			type = "executable",
			command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
			args = { "-m", "debugpy.adapter" },
		}
		dap.configurations.python = {
			{
				type = "python",
				request = "launch",
				name = "Launch Python File",
				program = "${file}",
				pythonPath = function()
					return "/usr/bin/python3" -- Change this if using a virtual environment
				end,
			},
		}
		-- 🦍 Go Debugging
		dap.adapters.go = {
			type = "server",
			port = 2345,
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
				args = { "dap", "-l", "127.0.0.1:2345" },
			},
		}
		dap.configurations.go = {
			{
				type = "go",
				name = "Debug Go File",
				request = "launch",
				program = "${file}",
			},
		}
		-- ⚡ JavaScript & TypeScript Debugging (Node.js)
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = 9229,
			executable = {
				command = "node",
				args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/out/src/jsDebug.js" },
			},
		}
		dap.configurations.javascript = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch Node.js",
				program = "${file}",
				cwd = "${workspaceFolder}",
				runtimeExecutable = "node",
			},
		}
		dap.configurations.typescript = dap.configurations.javascript
    ]]

    -- Set up DAP UI
    dapui.setup()

    -- Open DAP UI automatically on start and close on exit
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- Keybindings for DAP
    vim.keymap.set("n", "<F5>", function()
      dap.continue()
    end, { desc = "Start/Continue Debugging" })
    vim.keymap.set("n", "<F10>", function()
      dap.step_over()
    end, { desc = "Step Over" })
    vim.keymap.set("n", "<F11>", function()
      dap.step_into()
    end, { desc = "Step Into" })
    vim.keymap.set("n", "<F12>", function()
      dap.step_out()
    end, { desc = "Step Out" })
    vim.keymap.set("n", "<Leader>b", function()
      dap.toggle_breakpoint()
    end, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<Leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Set Conditional Breakpoint" })
    vim.keymap.set("n", "<Leader>dr", function()
      dap.repl.open()
    end, { desc = "Open Debug Console" })
    vim.keymap.set("n", "<Leader>du", function()
      dapui.toggle()
    end, { desc = "Toggle DAP UI" })
  end,
}
