command! -nargs=* TransArgs :call translate#controller#argument_mode(<f-args>)
command! -nargs=0 TransWord :call translate#controller#text_object_mode(<f-args>)
command! -nargs=0 -range TransVisual :call translate#controller#visual_mode()
