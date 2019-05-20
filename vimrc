" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Personalization: Grzegorz Dzień <gdzien@gmail.com>
" Last change:	2019 Jan 26

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'

call plug#end()

filetype off
filetype plugin indent on

set number
set relativenumber
set noswapfile
set noshowmode
set ts=2 sw=2 sts=2 et
set backspace=indent,eol,start

" Map <leader> to comma
let mapleader=","

if has("autocmd")
  autocmd FileType go set ts=2 sw=2 sts=2 noet nolist autowrite
endif
