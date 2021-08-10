local execute = vim.api.nvim_command
local fn = vim.fn

-- fn.stdpath('data') => ~/.local/share/nvim
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- Ensure that packer is available before trying to use packages.
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
	execute 'packadd packer.nvim'
end

return require('packer').startup({function()
	use 'danro/rename.vim'
	use {
		'dense-analysis/ale',
		config = function()
			vim.g['airline#extensions#ale#enabled'] = 1
			vim.g['ale_virtualtext_cursor'] = 1
			vim.g['ale_fix_on_save'] = 1

			vim.cmd('highlight ALEWarning gui=underline')
			vim.cmd('highlight ALEVirtualTextError guifg=#BF616A') -- red
			vim.cmd('highlight ALEVirtualTextWarning guifg=#EBCB8B') -- yellow
			vim.cmd('highlight ALEVirtualTextStyleWarning guifg=#EBCB8B') -- yellow
		end
	}

	use {
		'junegunn/fzf',
		config = function()
			local utils = require('config.utils') -- lua/config/utils.lua
			local map = utils.map

			map('n', '<C-p>', ':FZF<cr>', { noremap = true })
			map('n', '<Leader>t', ':FZF<cr>')
			map('n', '<Leader>b', ':Buffers<cr>')
			map('n', '<c-]>', ':Tags <c-r><c-w><cr>', { noremap = true })
		end,
		run = function()
			vim.fn['fzf#install']()
		end,
		requires = { 'junegunn/fzf.vim' },
	}

	use {
		'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
		config = function() require('gitsigns').setup() end
	}

	use {
		'ludovicchabant/vim-gutentags',
		config = function()
			vim.g['gutentags_file_list_command'] = "rg --files"
		end,
	}


	use {
		'ntpeters/vim-better-whitespace',
		config = function()
			vim.cmd('highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=#BF616A guifg=#C0C5CE')
		end,
	}

	use 'tomtom/tcomment_vim'

	-- All hail @tpope
	use {
		'tpope/vim-bundler',
		'tpope/vim-fugitive',
		{ 'tpope/vim-rails' },
		{
			'tpope/vim-rake',
			requires = {
				'tpope/vim-projectionist'
			}
		},
		{ 'tpope/vim-repeat' },
		{ 'tpope/vim-surround' }
	}

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

  use 'tpope/vim-endwise'

end, config = { display = { open_fn = require('packer.util').float }}})
