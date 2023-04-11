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
			vim.g['ale_virtualtext_cursor'] = 0
			vim.g['ale_fix_on_save'] = 1
			vim.g['ale_lint_on_enter'] = 0
			vim.g['ale_line_delay'] = 300
			-- vim.g['ale_set_highlights'] = 0

			vim.cmd('highlight ALEWarning gui=underline')
			vim.cmd('highlight ALEVirtualTextError guifg=#EBCB8B') -- red
			vim.cmd('highlight ALEVirtualTextWarning guifg=#565678') -- yellow
			vim.cmd('highlight ALEVirtualTextStyleWarning guifg=#565678') -- yellow
		end,
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
			map('n', 'KK', ':Rg  <C-R><C-W><CR>')
			map('n', 'Kk', ':Rg <C-R><C-W>')
			map('n', 'KD', ':Rg def (self\\.)?<C-R><C-W><CR>')
			map('n', 'KC', ':Rg class ([A-Za-z]+::)*<C-R><C-W><CR>')
			map('n', 'KM', ':Rg module ([A-Za-z]+::)*<C-R><C-W><CR>')
		end,
		run = function()
			vim.fn['fzf#install']()
		end,
		requires = { 'junegunn/fzf.vim' },
	}

	use {
		-- 'liuchengxu/vista.vim',
		'preservim/tagbar',
		setup = function()
			vim.g['tagbar_ctags_bin'] = '/usr/local/bin/ctags'
		end,
		config = function()
			-- vim.cmd('TagbarDebug')
			local utils = require('config.utils') -- lua/config/utils.lua
			local map = utils.map
			local vim_exec = utils.vim_exec

			map('n', '<C-L>', ':TagbarToggle<cr>', { noremap = true })
			-- map('n', '<C-L>', ':Vista!!<cr>', { noremap = true })

			vim.g['tagbar_autofocus'] = 1
			vim.g['tagbar_autoclose'] = 1
			vim.g['tagbar_left'] = 1
			vim.g['tagbar_ctags_bin'] = '/usr/local/bin/ctags'
			-- vim.g['vista#renderer#enable_icon'] = 1
			-- vim.g['vista_fzf_preview'] = {'left:50%'}
			-- vim.g['vista_default_executive'] = 'ctags'

			-- " allows for rules and ctags extending
			-- vim_exec([[
			--   let g:tagbar_type_ruby = {
			--       \ 'kinds' : [
			--           \ 'm:modules',
			--           \ 'c:classes',
			--           \ 'd:describes',
			--           \ 'C:contexts',
			--           \ 'f:methods',
			--           \ 'F:singleton methods',
			--           \ 't:task',
			--           \ 'o:on',
			--           \ 'g:get',
			--           \ 'p:post',
			--           \ 'u:put',
			--           \ 'a:patch',
			--           \ 'e:delete',
			--           \ 'i:options',
			--           \ 's:test',
			--       \ ]
			--   \ }
			-- ]])
		end,
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
					{ 'tpope/vim-fugitive',
					config = function()
						local utils = require('config.utils') -- lua/config/utils.lua
						local map = utils.map
						local vim_exec = utils.vim_exec

						vim_exec([[
						cnorea gs Git
						cnorea gc Gcommit
						cnorea gb GBrowse
						set statusline += "%{fugitive#statusline()}"
						]])
						-- vim.opt.statusline.concat("")
						-- abbrev('gs', 'Gstatus')
						-- abbrev('gc', 'Gcommit')
						map('', '<leader>d', ':diffoff<CR>')
					end,
				},
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
			use {
				"vim-test/vim-test",
				config = function()
					local utils = require('config.utils') -- lua/config/utils.lua
					local map = utils.map

					map('n', '<Leader>t', ':TestNearest<CR>')
					map('n', '<Leader>T', ':TestFile<CR>')
					map('n', '<Leader>q', ':ccl<CR>')
					vim.g['dispatch_tmux_height'] = 25
					vim.g['test#strategy'] = "dispatch"
				end,
			}
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
			use "junegunn/vim-peekaboo"

			use {
				"ctrlpvim/ctrlp.vim",
				config = function()
					local utils = require('config.utils') -- lua/config/utils.lua
					local map = utils.map

					map('n', '<Leader>fb', ':CtrlPBuffer<CR>')
					vim.g['ctrlp_match_window'] =  'bottom,order:btt,min:1,max:15,results:30'
					vim.g['ctrlp_clear_cache_on_exit'] = 1
					vim.g['ctrlp_max_depth'] = 40
					vim.g['ctrlp_user_command'] = {'.git', 'cd %s && git ls-files'}
					vim.g['ctrlp_by_filename'] = 0
					vim.g['ctrlp_map'] = '<c-p>'
					vim.g['ctrlp_cmd'] = 'CtrlPMRU'
				end,
			}

			use { "catppuccin/nvim", as = "catppuccin" }

		end, config = { display = { open_fn = require('packer.util').float }}})
