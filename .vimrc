"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stephen Mazich Vi Improved Configuration (VIMRC)                      "
" Copyright 2015 Stephen Mazich                                         "
"                                                                       "
"   Licensed under the "THE BEER-WARE LICENSE" (Revision 42):           "
"   Stephen Mazich wrote this file. As long as you retain this notice   "
"   you can do whatever you want with this stuff. If we meet some       "
"   day, and you think this stuff is worth it, you can buy me a         "
"   beer in return.                                                     "
"                                                                       "
" Maintainer:                                                           "
"   Stephen Mazich <stephen.mazich@gmail.com>                           "
"                                                                       "
" Version: 1.4                                                          "
"                                                                       "
" Created: 07/2015                                                      "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect
set nocompatible
"---------------------
"-- Plugin Settings --
"---------------------
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_config_file_enabled = 1
nmap \s :SyntasticToggleMode<CR>
nmap \e :SyntasticCheck<CR>

Plug 'scrooloose/nerdcommenter'

Plug 'altercation/vim-colors-solarized'

Plug 'ervandew/supertab'

Plug 'sickill/vim-pasta'

Plug 'tpope/vim-fugitive'

Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
let g:airline_solarized_normal_green = 1

Plug 'vim-airline/vim-airline-themes'
call plug#end()
"---------------------
"-- Plugin Settings --
"---------------------

set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set history=100                 " keep 100 lines of command line history
set ruler                       " show the cursor position all the time
set showcmd                     " display incomplete commands
set incsearch                   " do incremental searching
set wrapscan                    " search after EOF
set backup                      " keep a backup file
set backupdir=~/.vim/backup     " keep backups in a dir to avoid clutter
set ignorecase                  " ignores case when searching
set smartcase                   " search is now case sensitive
set hlsearch                    " matching search results are highlighted
set noeb vb t_vb=               " disable that damn beeping
set noshowmode                  " disable default mode display
set expandtab                   " tabs are spaces (even if I personally disagree)
set tabstop=4 shiftwidth=4 softtabstop=4    " Preffered tab setup

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " disable bell
    autocmd GUIEnter * set vb t_vb=

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
    augroup END
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>e :e<CR>
nnoremap <silent> <Leader>j :wincmd w<CR>
nnoremap <silent> <Leader>k :wincmd W<CR>
nnoremap <silent> <Leader>h :wincmd r<CR>
nnoremap <silent> <Leader>l :wincmd R<CR>
nnoremap <Leader>i :vsp<CR>
nnoremap <Leader>o :sp<CR>

if has('clipboard')
    vmap <Leader>y "+y
    vmap <Leader>d "+d
    nmap <Leader>p "+p
    nmap <Leader>P "+P
    vmap <Leader>p "+p
    vmap <Leader>P "+P
endif

nmap j gj
nmap k gk
nmap \n :set nu!<CR>
nmap \c :noh<CR>

"fat fingers remapping
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Filetype syntax
au BufNewFile,BufRead *.gradle setf groovy

syntax enable
set t_Co=256
set background=dark
colorscheme solarized

"Powerline Setup
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
function! AirlineInit()
    let spc = g:airline_symbols.space
    let linenbr = g:airline_symbols.linenr
    "let g:airline_section_b = airline#section#create_left(['branch','path'])
    "let g:airline_section_c = airline#section#create([])
    let g:airline_section_x = airline#section#create_right(['ffenc','filetype'])
    let g:airline_section_y = airline#section#create(['%p%%'])
    call airline#parts#define_raw('linenr', '%l')
    call airline#parts#define_accent('linenr', 'bold')
    let g:airline_section_z = airline#section#create([linenbr.spc, 'linenr',':%c'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
set laststatus=2
