set number
syntax on
filetype plugin indent on
set autoindent expandtab tabstop=4 shiftwidth=4
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'medium'
set encoding=UTF-8
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
Plugin 'junegunn/goyo.vim'
Plugin 'windwp/nvim-autopairs'
Plugin 'voldikss/vim-floaterm'
Plugin 'preservim/nerdtree' |
            \ Plugin 'Xuyuanp/nerdtree-git-plugin' |
            \ Plugin 'ryanoasis/vim-devicons' |
            \ Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

Plugin 'hrsh7th/nvim-cmp' |
            \ Plugin 'hrsh7th/cmp-buffer' |
            \ Plugin 'hrsh7th/cmp-path' |
	        \ Plugin 'hrsh7th/cmp-nvim-lsp' |
	        \ Plugin 'hrsh7th/cmp-nvim-lua'

Plugin 'williamboman/mason.nvim' |
            \ Plugin 'neovim/nvim-lspconfig' |
            \ Plugin 'williamboman/mason-lspconfig.nvim' |
call vundle#end()

lua <<EOF
    local mason = require'mason'
    mason.setup({
        ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    },
    init_opts = {
        auto_update = true,
        auto_install = true,
    },
    })

    local cmp = require'cmp'

    cmp.setup {
        mapping = {
            ["<C-Space>"] = cmp.mapping({
                i = function()
                    if cmp.visible() then
                        cmp.abort()
                    else
                        cmp.complete()
                        -- cmp.select_next_item()
                    end
                end,
                c = function()
                    if cmp.visible() then
                        cmp.close()
                    else
                        cmp.complete()
                    end
                end,
            }),

            --["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            ["<CR>"] = cmp.mapping.confirm { select = true },
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<Down>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<Up>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<C-Down>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" })
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
            ["<C-Up>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" })
                else
                    fallback()
                end
            end, {
                "i",
                "s",
            }),
        },
        formatting = {
            fields = { "kind", "abbr", "menu" },
            format = function(entry, vim_item)
                vim_item.menu = ({
                    nvim_lsp = "[LSP]",
                    buffer = "[Buf]",
                    path = "[Path]",
                })[entry.source.name]
                return vim_item
            end,
        },
        sources = {
            { name = "path" },
            { name = "nvim_lsp" },
            { name = "buffer" },
        },
        confirm_opts = {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        },
        window = {
            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            },
        },
        experimental = {
            ghost_text = false,
            native_menu = false,
        },
        completion = {
            autocomplete = false,
        },
        select_first = true,
    }
    vim.cmd [[highlight! link CmpItemAbbrMatchFuzzy Aqua]]
    vim.cmd [[highlight! link CmpItemKindText Fg]]
    vim.cmd [[highlight! link CmpItemKindMethod Purple]]
    vim.cmd [[highlight! link CmpItemKindFunction Purple]]
    vim.cmd [[highlight! link CmpItemKindConstructor Green]]
    vim.cmd [[highlight! link CmpItemKindField Aqua]]
    vim.cmd [[highlight! link CmpItemKindVariable Blue]]
    vim.cmd [[highlight! link CmpItemKindClass Green]]
    vim.cmd [[highlight! link CmpItemKindInterface Green]]
    vim.cmd [[highlight! link CmpItemKindValue Orange]]
    vim.cmd [[highlight! link CmpItemKindKeyword Keyword]]
    vim.cmd [[highlight! link CmpItemKindSnippet Red]]
    vim.cmd [[highlight! link CmpItemKindFile Orange]]
    vim.cmd [[highlight! link CmpItemKindFolder Orange]]


    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            signs = false,
            underline = true,
            virtual_text = true,
            --virtual_text = {
            --    spacing = 7,
            --    prefix = " << ",
            --    -- language server's name-- 
            --    source = "always",
            --    severity_limit = "Warning"
            --}
        }
    )
    

    local lspconfig = require'lspconfig'
    require'mason-lspconfig'.setup({
        ensure_installed = {'rust_analyzer'}
    })
    require'mason-lspconfig'.setup_handlers({
        function(server)
            lspconfig[server].setup({})
        end,
    })



    local autopairs = require'nvim-autopairs'
    autopairs.setup {
        check_ts = true,
        ts_config = {
            lua = { "string", "source" },
            javascript = { "string", "template_string" },
            java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'", "<", "|" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    }

    local cmp_autopairs = require'nvim-autopairs.completion.cmp'
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

EOF

let g:NERDTreeGitStatusUseNerdFonts = 1

let g:floaterm_keymap_toggle= '<f1>'
let g:floaterm_title = 'term($1|$2)'
let g:floaterm_width = 0.4
let g:floaterm_height = 0.4
let g:floaterm_position = 'bottomright'

vnoremap y "+y

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

xnoremap * :<c-u>let @/=@"<cr>gvy:let [@/,@"]=[@",@/]<cr>/\V<c-r>=substitute(escape(@/,'/\'),'\n','\\n','g')<cr><cr>


autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() == 0 |
            \ execute 'NERDTree' | wincmd p | enew | wincmd p |
            \ elseif argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | wincmd p | endif

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

