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
