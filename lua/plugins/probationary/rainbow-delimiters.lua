---@type LazySpec
return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "User AstroFile",
    main = "rainbow-delimiters.setup",
  },
  {
    "catppuccin/nvim",
    optional = true,
    ---@type CatppuccinOptions
    opts = { integrations = { rainbow_delimiters = true } },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    dependencies = { "HiPhish/rainbow-delimiters.nvim" },
    opts = function(_, opts)
      if not opts.scope then opts.scope = {} end
      opts.scope.show_start = true
      opts.scope.show_end = true
      opts.scope.highlight = vim.tbl_get(vim.g, "rainbow_delimiters", "highlight")
        or {
          "RainbowDelimiterRed",
          "RainbowDelimiterYellow",
          "RainbowDelimiterBlue",
          "RainbowDelimiterOrange",
          "RainbowDelimiterGreen",
          "RainbowDelimiterViolet",
          "RainbowDelimiterCyan",
        }
    end,

    config = function(plugin, opts)
      require(plugin.main).setup(opts)

      local hooks = require "ibl.hooks"
      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
    end,
  },
}
