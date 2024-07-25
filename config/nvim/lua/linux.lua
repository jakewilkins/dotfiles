
-- fail
-- exit
-- boom

vim.api.nvim_exec([[
" nnoremap <leader>cc :!'echo -n "%<Tab>"|pbcopy<CR>'
function! CopyFilenameToClipboard()
  silent !clear
  " execute "!echo " . expand("%") . " | /home/vscode/.dotfiles/codespaces-helpers/send-to-pasteboard"
  let var = system("/home/vscode/.dotfiles/codespaces-helpers/send-to-pasteboard", expand('%'))
endfunction
nnoremap <leader>cp :call CopyFilenameToClipboard()<cr>
]], false)

vim.api.nvim_exec([[
function CopyToOSClipboard() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| /home/vscode/.dotfiles/codespaces-helpers/send-to-pasteboard')
endfunction

vmap <leader>c :call CopyToOSClipboard()<cr>
]], false)
