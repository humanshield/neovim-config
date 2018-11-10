" lets see if I can get a basic neovim config re-constructed (RIP my own
" sense, 2017)
" this file should be in $HOME/.config/nvim/init.vim

" ----Plugins---- {{{

" Auto-download plug.vim if not found, install it, and reload.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter *PlugInstal --sync | source $MYVIMRC
endif

" specify a directory for plugins
call plug#begin('./plugged')
" let plug manage plug
Plug 'junegunn/vim-plug'
" tpope's stuff will go here...
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

" Color schemes
Plug 'crusoexia/vim-monokai'
Plug 'chriskempson/vim-tomorrow-theme'


" Useful stuff
Plug 'lervag/vimtex'
Plug 'airblade/vim-gitgutter'

" NERD Tree - tree explorer
" https://github.com/scrooloose/nerdtree
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERD Tree
Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()


" further airline config
" Automagically display all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
set noshowmode

" Auto start NERD tree when opening a directory
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p |
" endif

" Auto start NERD tree if no files are specified
autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' |
" endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

colorscheme Tomorrow-Night

" }}}

" file type recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
set list

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" you can do this with the ftplugin folder, I think
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab

" treat .rss files as XML
autocmd BufNewFile,BufRead *.rss setfiletype xml


" ----Keyboard Shortcuts and quick functions----{{{

" strip trailing whitespaces
nnoremap <silent> <F5> :call <SID> StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" Run it automagically when file is saved
" autocmd BufWritePre *.py,*.js :call <SID>StripTrailingWhitespaces()

" }}}


" ----Set things---- {{{

set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber

"  }}}
