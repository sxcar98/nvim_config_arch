-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README:
-- neovim-lua/README.md
-- https://github.com/brainfucksec/neovim-lua#readme

-- Automatically install packer
local vim = vim
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Install plugins
return packer.startup(function(use)
  -- Add you plugins here:
  use("wbthomason/packer.nvim") -- packer can manage itself

  use {
    "nvim-lua/plenary.nvim",
  }

  use { "ellisonleao/gruvbox.nvim",
    config = vim.cmd [[colorscheme gruvbox]],
  }

  use {
    "xiyaowong/nvim-transparent",
    config = function()
      require "plugins.transparent"
    end
  }

  -- Icons
  use("kyazdani42/nvim-web-devicons")

  -- File explorer
  use({
    "kyazdani42/nvim-tree.lua",
    config = function()
      require("plugins.nvimtree")
    end
  })

  -- Indent line
  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead",
    config = function()
      require("plugins.indentline")
    end,
  })

  -- Autopair
  use({
    "windwp/nvim-autopairs",
    after = 'nvim-cmp',
    config = function()
      require "plugins.autopairs"
    end,
  })

  -- Treesitter interface
  use { "nvim-treesitter/nvim-treesitter",
    config = function()
      require "plugins.treesitter"
    end, }

  -- LSP
  use({
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.lspconfig")
    end,
  })

  -- Autocomplete
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      -- "hrsh7th/cmp-buffer",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require "plugins.cmp"
    end,
  })

  use {
    'numToStr/Comment.nvim',
    keys = { "gc", "gb" },
    config = function()
      require 'plugins.comment'
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = function()
      require 'plugins.telescope'
    end,
  }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    config = function()
      require "plugins.lualine"
    end
  }

  -- git labels
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('plugins.gitsigns')
    end
  }

  -- Dashboard (start screen)
  use {
    disable = false,
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require 'plugins.alpha'
    end,
  }

  -- tabline
  use {
    "akinsho/bufferline.nvim",
    after = "nvim-web-devicons",
    config = function()
      require "plugins.bufferline"
    end,
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require("packer").sync()
  end
end)
