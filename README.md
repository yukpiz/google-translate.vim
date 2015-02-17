#### google-translate.vim

This plug-in is a translation tool to use Google Translate API.

##### Description


##### Dependents

* [vim-jp/vital.vim](https://github.com/vim-jp/vital.vim)


##### Installation

~~~
NeoBundle "yukpiz/google-translate.vim"
~~~

##### Usage

Translate word of the cursor position.  
~~~
:TransWord
~~~

Translate the input keywords.  
~~~
:TransArgs hello world
~~~

Translate a selection of visual mode.  
~~~
:'<,'>TransVisual
~~~

##### Customize options

The Google API there is a request limit.  
If you exceed the limit in my free frame you will not be able to use the plug-in.  
You can use your API key instead.  
~~~
let g:google_api_key = 'YOUR API KEY'
~~~

You can freely set the target language.  
Please look [here](https://cloud.google.com/translate/v2/using_rest?hl=ja#language-params) for language code.  
~~~
let g:translate_comparisons = {
\'en': 'ja',
\'ja': 'en',
\'etc': 'en',
\}
~~~


##### License

Public Domain  


##### Author

yukpiz \<yukpiz@gmail.com\>  


