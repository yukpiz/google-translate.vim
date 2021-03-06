function! translate#controller#text_object_mode()
    "Get a text object of cursor position.
    let word = expand('<cword>')
    call translate#init_options() "Initialize default options.
    let response =  translate#automatically_get(word)
    call translate#interface#open_target_only()
    call translate#interface#parse_buffer([response['data']['translations'][0]['translatedText']])
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
    let response = translate#automatically_get(strline)
    call translate#interface#open_target_only()
    call translate#interface#parse_buffer([response['data']['translations'][0]['translatedText']])
endfunction

function! translate#controller#visual_mode()
    "Get the selection string.
    let tmp = @@
    silent normal gvy
    let selected = @@
    let @@ = tmp
    call translate#init_options() "Initialize default options.
    let lines = split(selected, '\n')
    let response_list = []
    for line in lines
        let response = translate#automatically_get(line)
        call add(response_list, response['data']['translations'][0]['translatedText'])
    endfor
    call translate#interface#open_target_only()
    call translate#interface#parse_buffer(response_list)
endfunction

function! translate#controller#buffer_mode(bufinfo)
    let source_lang =
    \  getbufvar(a:bufinfo['source_buffer'], 'source_language', '')
    let target_lang =
    \  getbufvar(a:bufinfo['target_buffer'], 'target_language', '')

    let lines = getline(0, '$')
    let response_list = []
    for line in lines
        let response = translate#manually_get(line, source_lang, target_lang)
        call add(response_list, response['data']['translations'][0]['translatedText'])
    endfor
    call translate#interface#parse_buffer(response_list)
endfunction
