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
    if !exists('g:translate_comparisons')
        let g:translate_comparisons = {
        \  'en': 'ja',
        \  'ja': 'en',
        \  'etc': 'ja',
        \}
    else
        if !has_key(g:translate_comparisons, 'etc')
            let g:translate_comparisons['etc'] = g:translate_default_target
        endif
    endif

    "plugin's default variables
    let s:translate_response_type = 'json'
    let s:google_translate_url = 'https://www.googleapis.com/language/translate/v2'
    let s:google_detect_url = 'https://www.googleapis.com/language/translate/v2/detect'
endfunction

function! translate#target_set(lang)
    "TODO: check argument language.
endfunction

function! translate#source_set(lang)
    "TODO: check argument language.
endfunction

function! translate#lang_set(source_lang, target_lang)
    "TODO: check argument language.
endfunction

function! translate#automatically_get(q)
    let customize_parameters = {
    \  'key': g:google_api_key,
    \  'type': s:translate_response_type,
    \  'q': a:q,
    \}

    let decoded_json =
    \  translate#get(s:google_detect_url, customize_parameters)

    let auto_source = decoded_json['data']['detections'][0][0]['language']
    let auto_target =
    \  has_key(g:translate_comparisons, auto_source)
    \  ? g:translate_comparisons[auto_source]
    \  : g:translate_comparisons['etc']

    let request_parameters =
    \  translate#generate_parameters(a:q, auto_source, auto_target)
    return translate#get(s:google_translate_url, request_parameters)
endfunction

function! translate#manually_get(q, source_lang, target_lang)
    let request_parameters =
    \  translate#generate_parameters(a:q, a:source_lang, a:target_lang)
    return translate#get(s:google_translate_url, request_parameters)
endfunction

function! translate#get(url, request_parameters)
    let url = translate#generate_url(a:url, a:request_parameters)
    "Requires Vital.Web.HTTP
    let http_vital = vital#of('vital').import('Web.HTTP')
    let response = http_vital.get(url)
    let content = response.content

    "Requires Vital.Web.JSON
    let json_vital = vital#of('vital').import('Web.JSON')
    let decoded_json = json_vital.decode(content)

    return decoded_json
endfunction

function! translate#generate_parameters(q, source_lang, target_lang)
    return {
    \  'key': g:google_api_key,
    \  'source': a:source_lang,
    \  'target': a:target_lang,
    \  'type': s:translate_response_type,
    \  'q': a:q,
    \}
endfunction

function! translate#generate_url(url, request_parameters)
    "Requires Vital.Web.HTTP
    let http_vital = vital#of('vital').import('Web.HTTP')
    return a:url . '?' . http_vital.encodeURI(a:request_parameters)
endfunction
