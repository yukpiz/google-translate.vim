let s:bufinfo = {}
function! translate#interface#open()
    call translate#init_options()

    execute 'botright 7new target\ language'
    let s:bufinfo['target_buffer'] = bufnr('%')
    call translate#interface#target_buffer_settings()

    execute 'vnew source\ language'
    let s:bufinfo['source_buffer'] = bufnr('%')
    call translate#interface#source_buffer_settings()
endfunction

function! translate#interface#open_target_only()
    "TODO: TransWord, TransArgs, TransVisual...
endfunction

function! translate#interface#close()
    for b in range(1, bufnr('$'))
        let bufname = getbufvar(b, 'buffer_type')
        if bufname ==# 'trans_buffer'
            execute bufwinnr(b) . 'wincmd w'
            execute 'q'
        endif
    endfor
endfunction

function! translate#interface#target_buffer_settings()
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn nomodifiable
    setlocal statusline=TARGET\ LANGUAGE:\ ja
    call setbufvar(s:bufinfo['target_buffer'], 'buffer_type', 'trans_buffer')
    call setbufvar(
    \s:bufinfo['target_buffer'],
    \'target_language',
    \g:translate_default_target)
endfunction

function! translate#interface#source_buffer_settings()
    setlocal buftype=nowrite noswapfile bufhidden=wipe
    setlocal nonumber wrap nocursorcolumn
    setlocal statusline=SOURCE\ LANGUAGE:\ en
    call setbufvar(s:bufinfo['source_buffer'], 'buffer_type', 'trans_buffer')
    call setbufvar(
    \s:bufinfo['source_buffer'],
    \'source_language',
    \g:translate_default_source)
    autocmd InsertLeave <buffer> call translate#controller#buffer_mode(s:bufinfo)
    execute 'startinsert'
endfunction

function! translate#interface#parse_buffer(lines)
    execute bufwinnr(s:bufinfo['target_buffer']) . 'wincmd w'

    setlocal modifiable
    let linecount = len(getline(0, '$'))
    let i = 0
    while i < linecount
        execute 'delete'
        let i = i + 1
    endwhile

    call setline('.', a:lines)
    setlocal nomodifiable

    execute bufwinnr(s:bufinfo['source_buffer']) . 'wincmd w'
endfunction
