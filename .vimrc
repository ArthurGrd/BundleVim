set number
syntax on
filetype plugin indent on
set autoindent expandtab tabstop=4 shiftwidth=4
set background=dark
colorscheme retrobox
set backspace=2
set encoding=UTF-8
set mouse=a

call plug#begin()
Plug 'szw/vim-maximizer'
Plug 'Raimondi/delimitMate'
" Plug 'voldikss/vim-floaterm'

Plug 'preservim/nerdtree' |
          \ Plug 'Xuyuanp/nerdtree-git-plugin' |
          \ Plug 'ryanoasis/vim-devicons' |
          \ Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set updatetime=300
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

nmap <S-r> <Plug>(coc-rename)


let g:NERDTreeGitStatusUseNerdFonts = 1

" let g:floaterm_keymap_toggle= '<f1>'
" let g:floaterm_title = 'term($1|$2)'
" let g:floaterm_width = 0.4
" let g:floaterm_height = 0.4
" let g:floaterm_position = 'bottomright'

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

nnoremap <C-f> :MaximizerToggle<CR>
tnoremap <C-f> <C-\><C-n>:MaximizerToggle<CR>

xnoremap * :<c-u>let @/=@"<cr>gvy:let [@/,@"]=[@",@/]<cr>/\V<c-r>=substitute(escape(@/,'/\'),'\n','\\n','g')<cr><cr>

autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() == 0 |
            \ execute 'NERDTree' | wincmd p | enew | wincmd p |
            \ elseif argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
