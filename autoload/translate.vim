function! translate#controller()
    "TODO: function controller
endfunction

function! translate#init_options()
    if !exists('g:google_api_key')
        let g:google_api_key = 'AIzaSyAgy_6ymAn7u8HkW3Ozhk-RE0BzG9gfWig'
    endif
    if !exists('g:translate_default_source')
        let g:translate_default_source = 'en'
    endif
    if !exists('g:translate_default_target')
        let g:translate_default_target = 'ja'
    endif

    "plugin's default variables
    let translate_response_type = 'json'
    let s:google_translate_url = 'https://www.googleapis.com/language/translate/v2'

    "create parameters
    let s:request_parameters = {
    \'key': g:google_api_key,
    \'source': g:translate_default_source,
    \'target': g:translate_default_target,
    \'type': translate_response_type,
    \'q': '',
    \}
endfunction

function! translate#custom_options()
    "TODO: customize source and target language parameters.
endfunction

function! translate#get(query_string)
    call translate#options()
    let get_url =
    \s:google_translate_url . '?' .
    \'key=' . s:request_parameters['key'] . '&' .
    \'source=' . s:request_parameters['source'] . '&' .
    \'target=' . s:request_parameters['target'] . '&' .
    \'type=' . s:request_parameters['type'] . '&' .
    \'q=' . a:query_string
    let content = webapi#http#get(get_url).content
endfunction

function! translate#text_object()
    "TODO: mode text object
endfunction

function! translate#argument()
    "TODO: mode arguments
endfunction

function! translate#visual_mode()
    "TODO: selected in the visual mode
endfunction

