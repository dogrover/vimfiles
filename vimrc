" Cross-platform .vimrc file
" Tested on Windows and Linux

" After getting this file, bootstrap the vim configuration like this:
"    - git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
"    - create a symlink from ~/.vimrc to ~/.vim/vimrc
"    - For Windows, use "mklink /H _vimrc .vim\vimrc"
"    - start vim and run :BundleInstall

" Made this change from ~/.vim/vimrc

set nocompatible               " Not vi
filetype off                   " Required for Vundle

" OS-specific settings. Keep actual changes to a minimum. Set variables
" instead, and use them later.
if has('win32') || has('win64')
    " Override the default vimfiles path on Windows. Use .vim instead, which
    " makes cross-platform settings easier.
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
	set guifont=Bitstream_Vera_Sans_Mono:h8:cANSI
	set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
    let $BACKUPDIR=$HOME . "/Documents/VimBackup//,."
endif

if has('unix')
	set wildignore+=*/tmp/*,*.so,*.swp,*.zip
	let $BACKUPDIR=$HOME . "/VimBackup//,."
endif

" Invoke vundle
set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

" Bundles go here. Start with Vundle itself.
Bundle 'Lokaltog/vim-easymotion'
Bundle 'gmarik/vundle'
Bundle 'joedicastro/vim-markdown-extra-preview'
Bundle 'kien/ctrlp.vim'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-abolish'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'vim-scripts/Gundo'
Bundle 'vim-scripts/TWiki-Syntax'
Bundle 'vim-scripts/Tabular'
Bundle 'vim-scripts/buftabs'
Bundle 'w0ng/vim-hybrid'

" The rest of the settings
filetype plugin indent on               " Required after the Vundle stuff

" General editor settings
set autoread                            " Monitor open files for changes
set backspace=indent,eol,start          " Smart backspacing, where allowed
set cursorline                          " Highlight the row with the cursor
set diffopt=filler,iwhite               " Show all lines, ignore trailing spaces
set encoding=utf-8                      " Bye, ASCII
set helplang=En                         " Help is in English
set hidden                              " Keep changed buffers without saving
set history=200                         " Remember past commands
set laststatus=2                        " Always show a status line
set more                                " Prompt after a full screen of data
set nolazyredraw                        " Redraw as often as needed
set number                              " Always show line numbers
set numberwidth=6                       " Always keep six columns for line numbers
set ruler                               " Show rule at the bottom of the screen
set scrolloff=5							" Keep 5 rows visible around cursor row
set showcmd                             " Display partial commands in progress
set showfulltag                         " Show entire completion, when available
set showmode                            " Display the current editing mode
set sidescrolloff=5                     " Keep 5 columns visible around cursor
set synmaxcol=2048						" Prevent bogdown on long lines
set ttyfast                             " Fast terminal
set undofile                            " Create persistent undo history for each file
set undolevels=1000                     " Lots and lots of undo
set updatecount=100                     " Frequent updates to swapfile
set viminfo='100,h                      " Save marks from past files
set visualbell                          " No beeps, but do warn
set wildmenu                            " Menu has tab completion
set wildmode=list:longest               " More complete keyword completion
set window=80                           " Default size for new windows
syntax on

" Backup options. Consolidate all backups in a single location.
set backup
set backupdir=$BACKUPDIR
set undodir=$BACKUPDIR
set dir=$BACKUPDIR

" Revolt! Change the leader.
let mapleader = ","

" UI stuff
set guioptions=emr
set selectmode=mouse,key
:color hybrid

" Add Firefox-style buffer switching
noremap <C-Tab> :bnext<CR>
noremap <C-S-Tab> :bprev<CR>

" Let's fix search/move commands
" First, fix regex to work like everybody else's
nnoremap / /\v
vnoremap / /\v
set ignorecase                          " Default search is not case-sensitive
set smartcase                           " An uppercase makes search case sens.
set incsearch                           " Hilite matches
set showmatch                           " Show matching bracket
set hlsearch                            " Hilite the search term
set gdefault                            " Global is the new default, not one
" Quick un-highlight
nnoremap <leader><space> :noh<cr>
" Jump to bracket pairs more quickly
nnoremap <tab> %
vnoremap <tab> %

" Long lines, wrapping, and general indenting
set autoindent                          " Automatically indent
set formatoptions=qrn1                  " See 'fo-table' help
set linebreak                           " Better control over linebreaks
set shiftwidth=4                        " Indent 4 columns
set smartindent                         " C-style indenting is the norm
set smarttab                            " Do the right thing on new lines
set softtabstop=4                       " Soft-tabs are 4 columns
set tabstop=4                           " Tabs are 4 columns
set textwidth=79                        " Yeah, 80 columns is still a good idea
set whichwrap=b,s,<,>,[,]               " Which characters move across line breaks
set wrap                                " Display full text of line, wrapping if needed

" Bite the bullet! Disable Windoes-style movement keys.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" Best bits: Move by screen line, not by file line
nnoremap j gj
nnoremap k gk
" Make horizontal scrolling easier
nmap <silent> <C-o> 10zl
nmap <silent> <C-i> 10zh

" Quick macro to insert current date\time stamp 
:nnoremap <S-F5> "=strftime("%d-%b-%Y %H:%M:%S")<CR>P
:inoremap <S-F5> <C-R>=strftime("%d-%b-%Y %H:%M:%S")<CR>

" Settings for :TOhtml (built-in command)
let html_number_lines=1                 " Include line numbers
let html_use_css=1                      " Generate shorter HTML 4 file
let use_xhtml=1                         " Generate valid XHTML

" Keymappings which swap different text entities. See:
" http://vim.wikia.com/wiki/Swapping_characters,_words_and_lines 
" Swaps the current character with the next. Cursor stays.
:nnoremap <silent> gc xph
" Swaps the current word with the next, honoring puctuation, and keeping
" cursor in the same place. Works across newlines
:nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>
" Swap the current word with the previous, keeping cursor on current word
" (like 'pushing' the word to the left.)
:nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l> 
" Swap the current word with the next, keeping cursor on current word (like
" 'pushing' the word to the right.)
:nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>
" Swap the current paragraph with the next
:nnoremap g{ {dap}p{

" Buftabs settings
" https://github.com/vim-scripts/buftabs
let g:buftabs_only_basename=1                       " Don't show the directory name
"let g:buftabs_in_statusline=0                       " DON'T Put buffer list in the status line
let g:buftabs_active_highlight_group="Folded"       " Highlight the active buffer
let g:buftabs_inactive_highlight_group="NonText"    " Lowlight the inactive buffer list

" Handle known filetypes
au BufNewFile,BufRead *.jmx set filetype=xml

" Not sure the original source for this one. Invoking it on a highlighted item
" shows the highlighting group it belongs to. Now you know what group to
" update!
nmap <silent> ,qq :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" Working with .vimrc and other common rcs
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
nmap <silent> <leader>ep :e $HOME/.pentadactlyrc<CR>

" Gundo
nmap <C-F5> :GundoToggle<CR>

" Ctrl-P 
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

