" Write eyaml encrypted pass directly
" by Javi Polo
function! Feyaml()
    call inputsave()
    let my_pass = input('Secret: ')
    call inputrestore()
    let encpass = system("eyaml encrypt -o string -q -s ".my_pass." 2>/dev/null")
    call append(line('.'), split(encpass, '\v\n'))
    join
endfunction
nmap <Leader>E :call Feyaml()<CR>
