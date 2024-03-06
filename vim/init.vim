set number
execute pathogen#infect()
syntax on
filetype plugin indent on
autocmd vimenter * ++nested colorscheme gruvbox
set autoindent expandtab tabstop=4 shiftwidth=4


call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
Plug 'junegunn/goyo.vim'
Plug 'Raimondi/delimitMate'
Plug 'ervandew/supertab'
Plug 'voldikss/vim-floaterm'
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin' |
            \ Plug 'ryanoasis/vim-devicons' |
            \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ycm-core/YouCompleteMe'
Plug 'williamboman/mason.nvim'
Plug 'ncm2/float-preview.nvim'
call plug#end()


let g:ycm_global_ycm_extra_conf = '~/.config/nvim/global_extra_conf.py'

set encoding=UTF-8

let g:ycm_key_list_stop_completion = ['<Enter>']
set completeopt=longest,menuone
let g:ycm_auto_trigger = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

let g:float_preview#docked = 0
let g:float_preview#max_height = 40
let g:float_preview#max_width = 75

let g:NERDTreeGitStatusUseNerdFonts = 1

let g:floaterm_keymap_toggle= '<f1>'
let g:floaterm_title = 'term($1|$2)'
let g:floaterm_width = 0.4
let g:floaterm_height = 0.4
let g:floaterm_position = 'bottomright'


tnoremap <S-Up> <C-\><C-n><C-w>k
tnoremap <S-Down> <C-\><C-n>
tnoremap <S-Left> <C-\><C-n><C-w>h
tnoremap <S-Right> <C-\><C-n><C-w>l
tnoremap <C-w><C-w> <C-\><C-n><C-w><C-w>
tnoremap <C-n> <C-\><C-n>:NERDTreeToggle<CR>

nnoremap <S-Up> <C-w>k
nnoremap <S-Down> <C-w>j
nnoremap <S-Left> <C-w>h
nnoremap <S-Right> <C-w>l

nnoremap <C-n> :NERDTreeToggle<CR>


autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() == 0 |
            \ execute 'NERDTree' | wincmd p | enew | wincmd p |
            \ elseif argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

