
-- fail
-- exit
-- boom

vim.api.nvim_exec([[
" nnoremap <leader>cc :!'echo -n "%<Tab>"|pbcopy<CR>'
function! CopyFilenameToClipboard()
  silent !clear
  " execute "!echo " . expand("%") . " | /home/jsw/workspace/bug-free-fiesta/send-to-pasteboard"
  let var = system("/home/jsw/workspace/bug-free-fiesta/send-to-pasteboard", expand('%'))
endfunction
nnoremap <leader>cp :call CopyFilenameToClipboard()<cr>
]], false)

vim.api.nvim_exec([[
function CopyToOSClipboard() range
  echo system('echo '.shellescape(join(getline(a:firstline, a:lastline), "\n")).'| /usr/local/bin/pbcopy')
endfunction

vmap <leader>c :call CopyToOSClipboard()<cr>
]], false)
