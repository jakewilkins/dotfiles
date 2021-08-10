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
			-- vim.g['airline#extensions#ale#enabled'] = 1
			vim.g['ale_virtualtext_cursor'] = 1
			vim.g['ale_fix_on_save'] = 1
      vim.g['ale_lint_on_enter'] = 0
      vim.g['ale_line_delay'] = 300

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

	-- use {
	--   'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
	--   config = function() require('gitsigns').setup() end
	-- }

	-- use {
	--   'ludovicchabant/vim-gutentags',
	--   config = function()
	--     vim.g['gutentags_file_list_command'] = "rg --files"
	--   end,
	-- }


	use {
		'ntpeters/vim-better-whitespace',
		config = function()
			vim.cmd('highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=#BF616A guifg=#C0C5CE')
		end,
	}

	-- use 'tomtom/tcomment_vim'

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
		{ 'tpope/vim-surround' },
    { "tpope/vim-obsession" },
    { 'tpope/vim-endwise' },
    { 'tpope/vim-ragtag' },
    { 'tpope/vim-rhubarb' },
    { 'tpope/vim-dispatch' }
	}

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'


  -- Jake's plugins
  use "jgdavey/vim-blockle"
  use "rust-lang/rust.vim"
  use "geoffharcourt/vim-matchit"
  use "itspriddle/vim-marked"
  use "ervandew/supertab"
  use {
    "vim-ruby/vim-ruby",
    config = function()
      vim.g['ruby_indent_assignment_style'] = 'variable'
    end,
  }
  use "jparise/vim-graphql"
  use "matze/vim-move"
  use "Raimondi/delimitMate"
  use "joker1007/vim-ruby-heredoc-syntax"
  use "rizzatti/funcoo.vim"
  use "rking/vim-detailed"
  use "janko/vim-test"
  use "vim-scripts/L9"
  use {
    "scrooloose/nerdcommenter",
    config = function()
      vim.g['NERDSpaceDelims'] = 1
      vim.g['NERDDefaultAlign'] = 'left'
    end,
  }
  use "kchmck/vim-coffee-script"
  use "tommcdo/vim-exchange"
  use {
    "mileszs/ack.vim",
    config = function()
			local utils = require('config.utils') -- lua/config/utils.lua
			local map = utils.map
      vim.g['ackprg'] = 'rg --vimgrep --no-heading'
      map('n', 'KK', ':Ag \b<C-R><C-W>\b<CR>')
      map('n', 'Kk', ':Ag <C-R><C-W>')
      map('n', 'KD', ':Ag def (self\\.)?<C-R><C-W><CR>')
      map('n', 'KC', ':Ag class ([A-Za-z]+::)*<C-R><C-W><CR>')
      map('n', 'KC', ':Ag module ([A-Za-z]+::)*<C-R><C-W><CR>')
    end,
  }
  use "junegunn/vim-peekaboo"

  use {
    "ctrlpvim/ctrlp.vim",
    config = function()
			local utils = require('config.utils') -- lua/config/utils.lua
			local map = utils.map

      map('n', '<Leader>fb', ':CrlPBuffer<CR>')
      vim.g['ctrlp_match_window'] =  'bottom,order:btt,min:1,max:15,results:30'
      vim.g['ctrlp_clear_cache_on_exit'] = 1
      vim.g['ctrlp_max_depth'] = 40
      vim.g['ctrlp_user_command'] = {'.git', 'cd %s && git ls-files'}
      vim.g['ctrlp_by_filename'] = 0
      vim.g['ctrlp_map'] = '<c-p>'
      vim.g['ctrlp_cmd'] = 'CtrlPMRU'
    end,
  }

	use "cocopon/iceberg.vim"

end, config = { display = { open_fn = require('packer.util').float }}})
