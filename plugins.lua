local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "mhartington/formatter.nvim",
        config = function()
          require "custom.configs.formatter"
        end,
      },
      {
        "mfussenegger/nvim-lint",
        config = function()
          require "custom.configs.nvim-lint"
        end,
      },
      {
        "simrat39/rust-tools.nvim",
        config = function()
          require "custom.configs.rust-tools"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
          require "custom.configs.context"
        end,
      },
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      local opts = require "custom.configs.comment"

      require("Comment").setup(opts)
    end,
    dependencies = "JoosepAlviste/nvim-ts-context-commentstring",
  },

  {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require "custom.configs.luasnip"

          require("plugins.configs.others").luasnip(opts)
        end,
      },
    },
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require "custom.configs.better-escape"
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require "custom.configs.surround"
    end,
  },

  {
    "ggandor/lightspeed.nvim",
    dependencies = "tpope/vim-repeat",
    lazy = false,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
