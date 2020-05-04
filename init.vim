" lets see if I can get a basic neovim config re-constructed (RIP my own sense, 2017)
" this file should be in $HOME/.config/nvim/init.vim

" ----Plugins---- {{{

" Auto-download plug.vim if not found, install it, and reload.
if empty(glob('$HOME/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter *PlugInstal --sync | source $MYVIMRC
endif

" specify a directory for plugins
call plug#begin('$HOME/.config/nvim/plugged')
" let plug manage plug
Plug 'junegunn/vim-plug'
" tpope's stuff will go here...
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
" Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

" Color schemes
" Plug 'crusoexia/vim-monokai'
Plug 'chriskempson/vim-tomorrow-theme'


" Coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Useful stuff
" Plug 'lervag/vimtex'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'w0rp/ale'
Plug 'vim-pandoc/vim-pandoc-syntax'

" NERD Tree - tree explorer
" https://github.com/scrooloose/nerdtree
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" nerdtree-git-plugin - show git status in NERD Tree
" Plug 'Xuyuanp/nerdtree-git-plugin'

" vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()


" further airline sonfig
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
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | exe 'NERDTree' |
" endif

" Let quit work as expected if after entering :q the only window left open is NERD Tree itself
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" ALE Configuration

let g:ale_completion_enabled = 1                " Enable ALE
let g:airline#extensions#ale#enabled = 1        " Show ALE status in airline

colorscheme Tomorrow-Night-Bright

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" }}}


let mapleader = ","


" ----Keyboard Shortcuts and quick functions----{{{

" source vimrc when it's saved
autocmd BufWritePost $HOME/.config/nvim/init.vim source $MYVIMRC
nmap <leader>v :tabedit $MYVIMRC<CR>

nmap <leader>w :write<CR>

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

" toggle spell checking on and off with `<leader>s`
nmap <silent> <leader>s :set spell!<CR>
" set region to US english
set spelllang=en_us

" Coc stuff {{{
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
"if exists('*complete_info')
"  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" :
"  "\<C-g>u\<CR>"
"  else
"    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"    endif
"
"    " Use `[g` and `]g` to navigate diagnostics
"    nmap <silent> [g <Plug>(coc-diagnostic-prev)
"    nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"    " GoTo code navigation.
"    nmap <silent> gd <Plug>(coc-definition)
"    nmap <silent> gy <Plug>(coc-type-definition)
"    nmap <silent> gi <Plug>(coc-implementation)
"    nmap <silent> gr <Plug>(coc-references)
"
"    " Use K to show documentation in preview window.
"    nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"    function! s:show_documentation()
"      if (index(['vim','help'], &filetype) >= 0)
"          execute 'h '.expand('<cword>')
"            else
"                call CocAction('doHover')
"                  endif
"                  endfunction
"
"                  " Highlight the symbol and its references when holding the
"                  cursor.
"                  autocmd CursorHold * silent call
"                  CocActionAsync('highlight')
"
"                  " Symbol renaming.
"                  nmap <leader>rn <Plug>(coc-rename)
"
"                  " Formatting selected code.
"                  xmap <leader>f  <Plug>(coc-format-selected)
"                  nmap <leader>f  <Plug>(coc-format-selected)
"
"                  augroup mygroup
"                    autocmd!
"                      " Setup formatexpr specified filetype(s).
"                        autocmd FileType typescript,json setl
"                        formatexpr=CocAction('formatSelected')
"                          " Update signature help on jump placeholder.
"                            autocmd User CocJumpPlaceholder call
"                            CocActionAsync('showSignatureHelp')
"                            augroup end
"
"                            " Applying codeAction to the selected region.
"                            " Example: `<leader>aap` for current paragraph
"                            xmap <leader>a  <Plug>(coc-codeaction-selected)
"                            nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"                            " Remap keys for applying codeAction to the
"                            current line.
"                            nmap <leader>ac  <Plug>(coc-codeaction)
"                            " Apply AutoFix to problem on the current line.
"                            nmap <leader>qf  <Plug>(coc-fix-current)
"
"                            " Introduce function text object
"                            " NOTE: Requires 'textDocument.documentSymbol'
"                            support from the language server.
"                            xmap if <Plug>(coc-funcobj-i)
"                            xmap af <Plug>(coc-funcobj-a)
"                            omap if <Plug>(coc-funcobj-i)
"                            omap af <Plug>(coc-funcobj-a)
"
"                            " Use <TAB> for selections ranges.
"                            " NOTE: Requires 'textDocument/selectionRange'
"                            support from the language server.
"                            " coc-tsserver, coc-python are the examples of
"                            servers that support it.
"                            nmap <silent> <TAB> <Plug>(coc-range-select)
"                            xmap <silent> <TAB> <Plug>(coc-range-select)
"
"                            " Add `:Format` command to format current
"                            buffer.
"                            command! -nargs=0 Format :call
"                            CocAction('format')
"
"                            " Add `:Fold` command to fold current buffer.
"                            command! -nargs=? Fold :call
"                            CocAction('fold', <f-args>)
"
"                            " Add `:OR` command for organize imports of the
"                            current buffer.
"                            command! -nargs=0 OR   :call
"                            CocAction('runCommand',
"                            'editor.action.organizeImport')
"
"                            " Add (Neo)Vim's native statusline support.
"                            " NOTE: Please see `:h coc-status` for
"                            integrations with external plugins that
"                            " provide custom statusline: lightline.vim,
"                            vim-airline.
"                            set
"                            statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"                            " Mappings using CoCList:
"                            " Show all diagnostics.
"                            nnoremap <silent> <space>a  :<C-u>CocList
"                            diagnostics<cr>
"                            " Manage extensions.
"                            nnoremap <silent> <space>e  :<C-u>CocList
"                            extensions<cr>
"                            " Show commands.
"                            nnoremap <silent> <space>c  :<C-u>CocList
"                            commands<cr>
"                            " Find symbol of current document.
"                            nnoremap <silent> <space>o  :<C-u>CocList
"                            outline<cr>
"                            " Search workspace symbols.
"                            nnoremap <silent> <space>s  :<C-u>CocList -I
"                            symbols<cr>
"                            " Do default action for next item.
"                            nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"                            " Do default action for previous item.
"                            nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"                            " Resume latest coc list.
"                            nnoremap <silent> <space>p
"                             :<C-u>CocListResume<CR>
" }}}


" }}}


" ----Folding---- {{{

set foldlevel=2
set foldmethod=syntax

" space to toggle folds
nnoremap <Space> za
vnoremap <Space> za

nnoremap <leader>z zMzv

"  }}}


" ----Set things---- {{{


" file type recognition
filetype on
filetype plugin on
filetype indent on

" syntax highlighting
syntax on

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
set list

set wrap
set linebreak
command! -nargs=* Wrap set wrap linebreak nolist

" you can do this with the ftplugin folder, I think
autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab

" treat .rss files as XML
autocmd BufNewFile,BufRead *.rss setfiletype xml

" set hidden
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set number
set relativenumber
set modeline

"  }}}

" vim: foldmethod=marker
