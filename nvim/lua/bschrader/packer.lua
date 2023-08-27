-- Only required if you have packer configured as `opt`
 vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.1',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({ 
	  'rose-pine/neovim', 
	  as = 'rose-pine', 
	  config = function()   
	  	vim.cmd('colorscheme rose-pine')
	  end 
  })


  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use('akinsho/toggleterm.nvim')
  use({
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v2.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},             -- Required
		  {                                      -- Optional
		  'williamboman/mason.nvim',
		  run = function()
			  pcall(vim.cmd, 'MasonUpdate')
		  end,
	  },
	  {'williamboman/mason-lspconfig.nvim'}, -- Optional

	  -- Autocompletion
	  {'hrsh7th/nvim-cmp'},     -- Required
	  {'hrsh7th/cmp-nvim-lsp'}, -- Required
	  {'L3MON4D3/LuaSnip'},     -- Required
     }
  })
  use {
    'ten3roberts/qf.nvim',
    config = function()
      require'qf'.setup{}
    end
  }
    -- Debugging
  use 'mfussenegger/nvim-dap'               -- Debugging engine
  use 'mfussenegger/nvim-dap-python'        -- DAP settings
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} } -- UI and overlay
  use 'theHamsta/nvim-dap-virtual-text'     -- Virtual text summary

  use {
  "nvim-neotest/neotest",
    requires = {
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-plenary",
    "nvim-neotest/neotest-vim-test",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim"
    }
  }

end)
