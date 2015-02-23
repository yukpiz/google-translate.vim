function! translate#controller#text_object_mode()
    "Get a text object of cursor position.
    let word = expand('<cword>')
    call translate#init_options() "Initialize default options.
    "Call the common translation function.
    let response =  translate#automatically_get(word)
    echo response
endfunction

function! translate#controller#argument_mode(...)
    "Summarized the arguments into a single string.
    let i = 1
    let strline  = ''
    while i <= a:0
        let strline = strline . ' ' . get(a:, i, '')
        let i = i + 1
    endwhile
    call translate#init_options() "Initialize default options.
    "Call the common translation function.
    let response = translate#automatically_get(strline)
    echo response
endfunction

function! translate#controller#visual_mode()
    "Get the selection string.
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call translate#init_options() "Initialize default options.
    "Call the common translation function.
    let response = translate#automatically_get(selected)
    echo response
endfunction

function! translate#controller#buffer_mode()
    "manually_getを呼び出す為の準備
endfunction
