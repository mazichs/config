"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Stephen Mazich Vi Improved Configuration (VIMRC)						"
" Copyright 2015 Stephen Mazich											"
"																		"
"   Licensed under the "THE BEER-WARE LICENSE" (Revision 42):			"
"   Stephen Mazich wrote this file. As long as you retain this notice	"
"   you can do whatever you want with this stuff. If we meet some		"
"   day, and you think this stuff is worth it, you can buy me a			"
"   beer in return.														"
"																		"
" Maintainer:															"
"   Stephen Mazich <stephen.mazich@gmail.com>							"
"																		"
" Version: 1.3															"
"																		"
" Created: 07/2015														"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible			" required
filetype off				" required
"---------------------
"-- Vundle Settings --
"---------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_java_javac_config_file_enabled = 1
nmap \c :SyntasticToggleMode<CR>

Plugin 'scrooloose/nerdcommenter'

Plugin 'altercation/vim-colors-solarized'

Plugin 'ervandew/supertab'

Plugin 'sickill/vim-pasta'

call vundle#end()            " required
filetype plugin indent on    " required
"---------------------
"-- Vundle Settings --
"---------------------

set backspace=indent,eol,start	" allow backspacing over everything in insert modet
set history=100					" keep 100 lines of command line history
set ruler						" show the cursor position all the time
set showcmd						" display incomplete commands
set incsearch					" do incremental searching
set wrapscan					" search after EOF
set backup						" keep a backup file
set backupdir=~/.vim/backup		" keep backups in a dir to avoid clutter
set ignorecase					" ignores case when searching
set smartcase					" search is now case sensitive
set hlsearch					" matching search results are highlighted
set noeb vb t_vb=				" disable that damn beeping

set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4	" Preffered tab setup

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
nmap \e :NERDTreeToggle<CR>
nmap \p :set paste!<CR>
nmap \n :set nu!<CR>
nmap <F3> :noh<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

" tab stuff for when those dirty heathens can't keep their shit straight
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>

"fat fingers remapping
:command WQ wq
:command Wq wq
:command W w
:command Q q

" Filetype syntax
au BufNewFile,BufRead *.gradle setf groovy

"These settings have to be kept out of Vundle Settings
set t_Co=256
syntax enable
set background=dark
colorscheme solarized
let g:solarized_termcolors = 256
let g:solarized_termtrans  = 1
let g:solarized_degrade    = 0
let g:solarized_bold       = 1
let g:solarized_underline  = 1
let g:solarized_italic     = 1
let g:solarized_contrast   = "normal"
let g:solarized_visibility = "normal"

"Powerline Setup
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2
