function! translate#history#init_options()
endfunction

function! translate#history#syntax()
    call translate#history#init_options()
    syntax on
    call translate#history#level1_search_syntax('level1')
    call translate#history#level2_search_syntax('level2')
    call translate#history#level3_search_syntax('level3')
endfunction

function! translate#history#level1_search_syntax(text)
    execute 'syntax match Level1Color ''' . a:text . ''' display containedin=ALL'
    highlight Level1Color ctermbg=131
endfunction

function! translate#history#level2_search_syntax(text)
    execute 'syntax match Level2Color ''' . a:text . ''' display containedin=ALL'
    highlight Level2Color ctermbg=128
endfunction

function! translate#history#level3_search_syntax(text)
    execute 'syntax match Level3Color ''' . a:text . ''' display containedin=ALL'
    highlight Level3Color ctermbg=88
endfunction

"level1
"level2
"level3
"level4
"level5

