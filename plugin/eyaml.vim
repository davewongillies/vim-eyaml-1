" Write eyaml encrypted pass directly
" http://github.com/javipolo
"
function! Eyaml_input()
    call inputsave()
    let my_pass = input('Secret: ')
    call inputrestore()
    let encpass = system("eyaml encrypt -o string -q -s ".shellescape(my_pass)." 2>/dev/null")
    call append(line('.'), split(encpass, '\v\n'))
    join
endfunction

function! Eyaml(type)
    if a:type ==# 'v'
        " We are in visual character mode
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        " We are in normal mode
        execute "normal! `[v`]y"
    else
        return
    endif
    let cmd = "eyaml encrypt -o string -q -s ".shellescape(@@)." 2>/dev/null"
    let encpass = split(system(cmd),'\v\n')[0]
    if a:type ==# 'v'
        execute "normal! `<v`>s".encpass
        execute "normal! `<"
    elseif a:type ==# 'char'
        execute "normal! `[v`]s".encpass
        execute "normal! `["
    endif
endfunction

nnoremap <silent> <Leader>E :call Eyaml_input()<CR>
nnoremap <silent> <Leader>e :set operatorfunc=Eyaml<cr>g@
vnoremap <silent> <Leader>e :<C-U>call Eyaml(visualmode())<CR>
