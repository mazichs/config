"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"																		"
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
" Version: 1.2															"
"																		"
" Created: 07/09/2015													"
"																		"
" History:                                                              "
"  07/09/2015 -- Stephen Mazich											"
"    File created with settings from previous vimrc.					"
"    Version number respects previous iterations of						"
"    non licensed vimrc files.											"
"																		"
"  08/10/2015 -- Stephen Mazich											"
"    Plugin Changes														"
"																		"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"---------------------
"-- Vundle Settings --
"---------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

Plugin 'kien/ctrlp.vim' 

Plugin 'scrooloose/nerdtree' 

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

Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'} 
"Plugin 'bling/vim-airline'
"let g:airline_powerline_fonts = 1
"let g:airline_theme = 'solarized'
set laststatus=2
set t_Co=256

Plugin 'altercation/vim-colors-solarized' 

Plugin 'ervandew/supertab'

Plugin 'sickill/vim-pasta'

"Plugin 'ryanoasis/vim-devicons'

call vundle#end()            " required
filetype plugin indent on    " required
"---------------------
"-- Vundle Settings --
"---------------------

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=100				" keep 100 lines of command line history
set ruler					" show the cursor position all the time
set showcmd					" display incomplete commands
set incsearch				" do incremental searching
set wrapscan				" search after EOF
set backup					" keep a backup file
set backupdir=~/.vim/backup	"keep backups in a dir to avoid clutter

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

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

else

set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Leader changes
" This is the greatest thing ever
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>x :x<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>e :e<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

nmap j gj
nmap k gk
set smartcase
set ignorecase
"nmap <C-c> <Esc>
nmap \e :NERDTreeToggle<CR>
nmap \l :setlocal number!<CR>	
nmap \p :set paste!<CR>

" tab stuff for when those dirty heathens can't keep their shit straight
nmap \t :set expandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \T :set expandtab tabstop=8 shiftwidth=8 softtabstop=4<CR>
nmap \M :set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4<CR>
nmap \m :set expandtab tabstop=2 shiftwidth=2 softtabstop=2<CR>
nmap \w :setlocal wrap!<CR>:setlocal wrap?<CR>

"line number toggle
nmap \n :set nu!<CR>

" gold standard in tabs. also fuck spaces
set noexpandtab tabstop=4 shiftwidth=4 softtabstop=4

"clears highlighting
nmap <F3> :noh<CR>

"fat fingers remapping
:command WQ wq
:command Wq wq
:command W w
:command Q q
set hlsearch

"disable that damn beeping
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

"These settings have to be kept out of Vundle Settings
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
