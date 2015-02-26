"Translation by function arguments.
command! -nargs=* TransArgs :call translate#controller#argument_mode(<f-args>)

"Translation of the Vim text object.
command! -nargs=0 TransWord :call translate#controller#text_object_mode(<f-args>)

"Call the translation of visual mode selections.
command! -nargs=0 -range TransVisual :call translate#controller#visual_mode()

"Open the translation buffer interface.
command! -nargs=0 Trans :call translate#interface#open()

"Close the translation buffer interface.
command! -nargs=0 TransClose :call translate#interface#close()

command! -nargs=1 TransTargetSet :call translate#target_set(<f-args>)
command! -nargs=1 TransSourceSet :call translate#source_set(<f-args>)
command! -nargs=+ TransLangSet :call translate#lang_set(<f-args>)

"Syntax Example
command! -nargs=0 TransHistory :call translate#history#syntax()
function! HighLightText(text)
    syntax on
    execute 'syntax match RedColor ''' . a:text . ''' display containedin=ALL'
    highlight RedColor ctermbg=Green
    "syntax match RedColor text display containedin=ALL
    "syntax match YellowColor 'Trans' display containedin=ALL
    "highlight YellowColor ctermbg=Red guibg=Red
endfunction
