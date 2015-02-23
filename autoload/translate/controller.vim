function! translate#controller#text_object_mode()
    "Get a text object of cursor position.
    let word = expand('<cword>')
    "Call the common translation function.
    call translate#controller#translation(word)
endfunction

function! translate#controller#argument_mode(...)
    "Summarized the arguments into a single string.
    let i = 1
    let strline  = ''
    while i <= a:0
        let strline = strline . ' ' . get(a:, i, '')
        let i = i + 1
    endwhile
    "Call the common translation function.
    call translate#controller#translation(strline)
endfunction

function! translate#controller#visual_mode()
    "Get the selection string.
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    "Call the common translation function.
    call translate#controller#translation(selected)
endfunction

function! translate#controller#translation(query_string)
    call translate#init_options() "Initialize default options.
    "Call 'Google Translate Rocks' and get source language.
    let auto_source = translate#get_auto_source(a:query_string)

    "Generate custom parameters and reflect it.
    let custom_parameters = {
    \'source': auto_source
    \}
    call translate#custom_options(custom_parameters)

    "Execute translation.
    call translate#get(a:query_string)
endfunction
