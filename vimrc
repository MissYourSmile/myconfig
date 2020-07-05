" base setting
syntax enable
syntax on

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on

set number
set relativenumber
set showmode
set showcmd
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set autoindent
set mouse=a
set nobackup
set noswapfile
set encoding=utf-8
set hlsearch
exec "nohlsearch"
set ignorecase
set smartcase
set wildmenu

" map
let mapleader = "\<space>"
map s <nop>
map Q :q<CR>
map S :w<CR>
map R :source $MYVIMRC<CR>
nmap <leader><CR> :nohlsearch<CR>

map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sj :set splitbelow<CR>:split<CR>
map sk :set nosplitright<CR>:split<CR>

map <leader>h <C-w>h
map <leader>j <C-w>j
map <leader>k <C-w>k
map <leader>l <C-w>l

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

map tn :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>

map sv <C-w>t<C-w>H
map sh <C-w>t<C-w>K

map <leader>nt :NERDTreeToggle<CR>
map <F8> :Tlist<CR>
map <F5> :call ComplieAndRun() <CR>

" vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/minibufexplorerpp'

Plug 'SirVer/ultisnips'
Plug 'MissYourSmile/vim-snippets'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'

call plug#end()

set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" taglist
let Tlist_Show_One_File=1       " 只展示一个文件的taglist
let Tlist_Exit_OnlyWindow=1     " 当taglist是最后一个窗口时自动退出
let Tlist_Use_Right_Window=1    " 在右边显示taglist窗口
let Tlist_Sort_Type="name"      " tag按名字排序

" ultisnips
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" vim-latex
let g:tex_flavor='latex'

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_math = 1

" vim-markdown-preview

"============================
"  自动添加文件头
"============================
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python3")
        call append(line("."),"# coding=utf-8")
        call append(line(".")+1, "") 
    else 
        call setline(1, "/*")
        call append(line("."), " * ".expand("%"))
        call append(line(".")+1, " */")
        call append(line(".")+2, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+3, "#include<iostream>")
        call append(line(".")+4, "using namespace std;")
        call append(line(".")+5, "")
    endif
    if &filetype == 'c'
        call append(line(".")+3, "#include<stdio.h>")
        call append(line(".")+4, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+3, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+4, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+5, "#endif")
    endif
    if &filetype == 'java'
        call append(line(".")+1,"public class ".expand("%:r"))
        call append(line(".")+2,"")
    endif
    "新建文件后，自动定位到文件末尾
endfunc 
autocmd BufNewFile * normal G

"============================
"  函数定义
"============================
"编译
func! ComplieAndRun()
        exec "w"
        if &filetype == 'c'
        exec "!gcc % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -std=c++11 -o %<"
        exec "!time ./%<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
       "exec "!time python2.7 %"
        exec "!time python3 %"
    elseif &filetype == 'html'
        exec "!google-chrome % &"
    elseif &filetype == 'tex'
        exec "!xelatex -synctex=1 -interaction=nonstopmode -pdf % &"
        exec "!xdg-open %<.pdf"
    elseif &filetype == 'markdown'
        exec "!pandoc --toc --latex-engine=xelatex % -o %<.pdf"
        exec "!xdg-open %<.pdf"
    endif
endfunc

