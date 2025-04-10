return {
  --mason: install all lsp's.
  {
    "williamboman/mason.nvim",

    config = function()
      require("mason").setup()
    end,
  },
  --mason lsp-config: bridges gap b/w mason and nvim lsp-config, and gives ensure_installed property.
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "pyright", "clangd", "rust-analyzer" },
      })
    end,
  },
  --nvim lsp-config:
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      --lua
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      --jsx
      lspconfig.ts_ls.setup({ capabilities = capabilities })
      --python
      lspconfig.pyright.setup({ capabilities = capabilities })
      --c/cpp
      lspconfig.clangd.setup({ capabilities = capabilities })
      --rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            procMacro = { enable = true },
            diagnostics = { enable = true },
          },
        },
        cmd = { "rustup", "run", "stable", "rust-analyzer" },
      })
      lspconfig.emmet_language_server.setup({
        filetypes = {
          "html",
          "css",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
          "php",
          "xml",
          "xsl",
          "pug",
          "blade",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true, -- Enable BEM syntax
            },
          },
        },
      })

      --hover over stuff for documentation.
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      --go to definition
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      -- go to reference
      vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
      --code action:
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
