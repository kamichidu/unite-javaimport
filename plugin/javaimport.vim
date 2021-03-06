" The MIT License (MIT)
"
" Copyright (c) 2014 kamichidu
"
" Permission is hereby granted, free of charge, to any person obtaining a copy
" of this software and associated documentation files (the "Software"), to deal
" in the Software without restriction, including without limitation the rights
" to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
" copies of the Software, and to permit persons to whom the Software is
" furnished to do so, subject to the following conditions:
"
" The above copyright notice and this permission notice shall be included in
" all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
" IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
" FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
" LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
" OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.
if exists('g:loaded_javaimport') && g:loaded_javaimport
    finish
endif
let g:loaded_javaimport= 1

let s:save_cpo= &cpo
set cpo&vim

let g:javaimport_version= '0.4.0'

if !exists('g:javaimport_use_default_mapping')
    let g:javaimport_use_default_mapping= 1
endif

if has('win64') || has('win32') || has('win16') || has('win95')
    let s:default_jvm= expand('$JAVA_HOME/bin/javaw')
else
    let s:default_jvm= expand('$JAVA_HOME/bin/java')
endif

let g:javaimport_config= get(g:, 'javaimport_config', {})
let g:javaimport_config.cache_dir= get(g:javaimport_config, 'cache_dir', expand('~/.javaimport/'))
let g:javaimport_config.preview_using= get(g:javaimport_config, 'preview_using', 'w3m')
let g:javaimport_config.debug_mode= get(g:javaimport_config, 'debug_mode', 0)
let g:javaimport_config.exclude_packages= get(g:javaimport_config, 'exclude_packages', [
\   'com.oracle',
\   'com.sun',
\   'sun',
\   'sunw',
\   'org.ietf',
\   'org.jcp',
\   'org.omg',
\   'org.w3c',
\   'org.xml',
\])
let g:javaimport_config.jvm= get(g:javaimport_config, 'jvm', s:default_jvm)
let g:javaimport_config.jvmargs= get(g:javaimport_config, 'jvmargs', '')

command! JavaImportClearCache call javaimport#clear_cache()
command! JavaImportSortStatements call javaimport#sort_import_statements()
command! JavaImportRemoveUnnecessaries call javaimport#remove_unnecesarries()

command! CtrlPJavaImportClass call ctrlp#init(ctrlp#javaimport#class#id())
command! CtrlPJavaImportField call ctrlp#init(ctrlp#javaimport#field#id())
command! CtrlPJavaImportMethod call ctrlp#init(ctrlp#javaimport#method#id())

nmap <silent><Plug>(javaimport-quickimport) :<C-U>call javaimport#quickimport(expand('<cword>'))<CR>

if g:javaimport_use_default_mapping
    nmap <Leader>I <Plug>(javaimport-quickimport)
endif

let &cpo= s:save_cpo
unlet s:save_cpo
