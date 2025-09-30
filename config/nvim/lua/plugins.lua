-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
  "danro/rename.vim",
  
  {
    "dense-analysis/ale",
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
  },

  {
    "junegunn/fzf",
    build = ":call fzf#install()",
    dependencies = { "junegunn/fzf.vim" },
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
  },

  {
    "preservim/tagbar",
    init = function()
      vim.g['tagbar_ctags_bin'] = '/usr/bin/ctags'
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
      vim.g['tagbar_ctags_bin'] = '/usr/bin/ctags'
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
  },

  -- {
  --   'lewis6991/gitsigns.nvim', 
  --   dependencies = { 'nvim-lua/plenary.nvim' },
  --   config = function() require('gitsigns').setup() end
  -- },

  -- {
  --   'ludovicchabant/vim-gutentags',
  --   config = function()
  --     vim.g['gutentags_file_list_command'] = "rg --files"
  --   end,
  -- },

  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.cmd('highlight ExtraWhitespace ctermbg=red ctermfg=white guibg=#BF616A guifg=#C0C5CE')
    end,
  },

  -- "tomtom/tcomment_vim",

  -- All hail @tpope
  "tpope/vim-bundler",
  {
    "tpope/vim-fugitive",
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
  "tpope/vim-rails",
  {
    "tpope/vim-rake",
    dependencies = { "tpope/vim-projectionist" }
  },
  "tpope/vim-repeat",
  "tpope/vim-surround",
  "tpope/vim-obsession",
  "tpope/vim-endwise",
  "tpope/vim-ragtag",
  "tpope/vim-rhubarb",
  "tpope/vim-dispatch",

  -- Jake's plugins
  "jgdavey/vim-blockle",
  "rust-lang/rust.vim",
  "geoffharcourt/vim-matchit",
  "itspriddle/vim-marked",
  "ervandew/supertab",
  {
    "vim-ruby/vim-ruby",
    config = function()
      vim.g['ruby_indent_assignment_style'] = 'variable'
    end,
  },
  "jparise/vim-graphql",
  "matze/vim-move",
  "Raimondi/delimitMate",
  "joker1007/vim-ruby-heredoc-syntax",
  "rizzatti/funcoo.vim",
  "rking/vim-detailed",
  {
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
  },
  "vim-scripts/L9",
  {
    "scrooloose/nerdcommenter",
    config = function()
      vim.g['NERDSpaceDelims'] = 1
      vim.g['NERDDefaultAlign'] = 'left'
    end,
  },
  "kchmck/vim-coffee-script",
  "tommcdo/vim-exchange",
  "junegunn/vim-peekaboo",
  "keith/swift.vim",

  {
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
  },

  { "catppuccin/nvim", name = "catppuccin" },
  "github/copilot.vim",
  "fatih/vim-go",
})
