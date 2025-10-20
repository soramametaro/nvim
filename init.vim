if &compatible
  set nocompatible
endif

let $CACHE = expand('~/.cache')
if !($CACHE->isdirectory())
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dir = 'dein.vim'->fnamemodify(':p')
  if !(s:dir->isdirectory())
    let s:dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !(s:dir->isdirectory())
      execute '!git clone https://github.com/Shougo/dein.vim' s:dir
    endif
  endif
  execute 'set runtimepath^='
        \ .. s:dir->fnamemodify(':p')->substitute('[/\\]$', '', '')
endif

" 外部設定ファイルの読み込み
runtime! option.vim
runtime! keymap.vim
runtime! dein.vim

" シンタックスハイライトをONにする
syntax enable

"C++をいい感じにコンパイルしてくれる関数
function! Cpprun()   
  :w
  :!g++ % -o %:r.out
endfunction

command! Cpprun call Cpprun()
noremap <space>g :Cpprun<CR>

"C++をいい感じにコンパイルしてくれる関数
function! Cppout()   
  :!./ %:r.out
endfunction

command! Cppout call Cppout()
noremap <space>m :Cppout<CR>


"Pythonを実行してくれる関数
function! Pythonrun()   
  :w
  :!python %
endfunction

command! Pythonrun call Pythonrun()
noremap <space>py :Pythonrun<CR>

"C言語をいい感じにコンパイル実行してくれる関数
function! Crun() 
  :w
  :!gcc % -o %:r.out
endfunction

command! Crun call Crun()
noremap <space>gcc :Crun<CR>

"C++ファイルでGLUTをコンパイルする
"windows用
"function! Cppglutrun()   
"  :w
"  :!g++ -Wall -Weffc++ -o %:r.out % -lglut -lGLU -lGL
"endfunction
"mac用
function! Cppglutrun()   
  :w
  :!g++ % -framework OpenGL -framework GLUT -DGL_SILENCE_DEPRECATION -o %:r.out
endfunction


command! Cppglutrun call Cppglutrun()
noremap <space>gl :Cppglutrun<CR>

"vimspectorを呼び出す
function! LaunchFileDebug()
    :call vimspector#LaunchWithSettings({'configuration': &filetype.'_file'})
endfunction

command! LaunchFileDebug call LaunchFileDebug()
noremap <space>lfd :LaunchFileDebug<CR>

"vscodeに似たキー配置(若干違う)
let g:vimspector_enable_mappings = 'HUMAN'

" VSCode内かどうかの分岐
if exists('g:vscode')
  " <Space>df で VSCode の定義へ移動
  nnoremap <silent> <Space>df <Cmd>call VSCodeNotify('editor.action.revealDefinition')<CR>
  " ついでにプレビュー派なら
  nnoremap <silent> <Space>dp <Cmd>call VSCodeNotify('editor.action.peekDefinition')<CR>
endif
