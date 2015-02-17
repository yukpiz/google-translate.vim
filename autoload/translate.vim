function! translate#controller()
    "TODO: function controller
endfunction

function! translate#init_options()
    if !exists('g:google_api_key')
        let g:google_api_key = 'AIzaSyAgy_6ymAn7u8HkW3Ozhk-RE0BzG9gfWig'
    endif

    let s:translate_default_source = 'en'
    let s:translate_default_target = 'ja'
    if !exists('g:translate_comparisons')
        let g:translate_comparisons = {
        \'en': 'ja',
        \'ja': 'en',
        \'etc': 'ja',
        \}
    else
        if !has_key(g:translate_comparisons, 'etc')
            let g:translate_comparisons['etc'] = s:translate_default_target
        endif
    endif

    "plugin's default variables
    let translate_response_type = 'json'
    let s:google_translate_url = 'https://www.googleapis.com/language/translate/v2'
    let s:google_detect_url = 'https://www.googleapis.com/language/translate/v2/detect'

    "create parameters
    let s:request_parameters = {
    \'key': g:google_api_key,
    \'source': s:translate_default_source,
    \'target': s:translate_default_target,
    \'type': translate_response_type,
    \'q': '',
    \}
endfunction

function! translate#custom_options(custom_parameters)
    if has_key(a:custom_parameters, 'source')
        let source = a:custom_parameters['source']
        "Customize source language
        let s:request_parameters['source'] = source
        "Customize target language
        let s:request_parameters['target'] =
        \has_key(g:translate_comparisons, source)
        \? g:translate_comparisons[source]
        \: g:translate_comparisons['etc']
    endif
endfunction

function! translate#get(query_string)
    let url =
    \s:google_translate_url . '?' .
    \'key=' . s:request_parameters['key'] . '&' .
    \'target=' . s:request_parameters['target'] . '&' .
    \'type=' . s:request_parameters['type'] . '&' .
    \'q=' . a:query_string

    let http_vital = vital#of('vital').import('Web.HTTP')
    let response = http_vital.get(url)
    let content = response.content
    echo content
endfunction

function! translate#rocks(query_string)
    call translate#init_options()
    let url =
    \s:google_detect_url . '?' .
    \'key=' . s:request_parameters['key'] . '&' .
    \'type=' . s:request_parameters['type'] . '&' .
    \'q=' . a:query_string

    "Requires Vital.Web.HTTP
    let http_vital = vital#of('vital').import('Web.HTTP')
    let response = http_vital.get(url) "If the response is if error?
    let content = response.content

    "Requires Vital.Web.JSON
    let json_vital = vital#of('vital').import('Web.JSON')
    let decoded_json = json_vital.decode(content)

    let custom_parameters = {
    \'source': decoded_json['data']['detections'][0][0]['language'],
    \}

    call translate#custom_options(custom_parameters)
    call translate#get(a:query_string)
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

