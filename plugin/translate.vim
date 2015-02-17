command! -nargs=* TransArgs :call translate#argument(<f-args>)
command! -nargs=0 TransWord :call translate#text_object(<f-args>)
command! -nargs=0 -range TransVisual :call translate#visual_mode()
