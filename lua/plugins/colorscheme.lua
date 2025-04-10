return {
  "rose-pine/neovim",
  name = "rose-pine",
  priority = 1000,

  config = function()
    require("rose-pine").setup({
      variant = "main",   -- auto, main, moon, or dawn
      dark_variant = "main", -- main, moon, or dawn
      dim_inactive_windows = false,
      extend_background_behind_borders = true,

      enable = {
        terminal = true,
        legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
        migrations = true,    -- Handle deprecated options automatically
      },

      styles = {
        bold = true,
        italic = true,
        transparency = false,
      },

      groups = {
        border = "muted",
        link = "iris",
        panel = "surface",

        error = "love",
        hint = "iris",
        info = "foam",
        note = "pine",
        todo = "rose",
        warn = "gold",

        git_add = "foam",
        git_change = "rose",
        git_delete = "love",
        git_dirty = "rose",
        git_ignore = "muted",
        git_merge = "iris",
        git_rename = "pine",
        git_stage = "iris",
        git_text = "rose",
        git_untracked = "subtle",

        h1 = "iris",
        h2 = "foam",
        h3 = "rose",
        h4 = "gold",
        h5 = "pine",
        h6 = "foam",
      },

      palette = {
        -- Override the builtin palette per variant
        main = {
          base = "#000000",
          overlay = "#293241",
        },
      },

      highlight_groups = {
        --  Comment = { fg = "foam" },
        --  VertSplit = { fg = "muted", bg = "muted" },
      },

      before_highlight = function(group, highlight, palette)
        -- Disable all undercurls
        -- if highlight.undercurl then
        --     highlight.undercurl = false
        -- end
        --
        -- Change palette colour
        -- if highlight.fg == palette.pine then
        --     highlight.fg = palette.foam
        -- end
      end,
    })

    -- setup must be called before loading
    vim.cmd("colorscheme rose-pine")

    --number line:
    -- removes brown strip
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
    -- Set the background color for the line number column
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "#2E2E2E" })
    -- Set the color for the current line number
    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ADD8E6" })
    --
    vim.opt.cursorline = true
    -- Set the color for the relative line numbers
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#A9A9A9" })
  end,
}
