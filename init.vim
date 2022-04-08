"=== Auto load for first time uses

lua require('basic')
lua require('keybindings')

" 插件配置
"lua require('plugin-config/which-key')
"lua require('plugin-config/nvim-treesitter')
"lua require('plugin-config/surround')
"lua require('plugin-config/nvim-colorizer')
"
let mapleader=" "
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l 
noremap <LEADER>b :bnext<CR>
noremap <LEADER>B :bprev<CR>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

set path+=~/.config/nvim/**

"set spell

set nocompatible
filetype plugin on
runtime macros/matchit.vim

" ------------------------ plug ---------------------------------
call plug#begin('$HOME/.config/nvim/plugged') 

Plug 'vim-airline/vim-airline'
Plug 'connorholyday/vim-snazzy'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" highlight
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" add 注释 
" [num]<LEADER>cc add
" [num]<LEADER>cu remove
Plug 'scrooloose/nerdcommenter'

" file 
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround'

"  ==== file find ===== 
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" ========== markdown ==========
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

" ===
" === show the buffer in line
" ===
Plug 'bling/vim-bufferline'

Plug 'majutsushi/tagbar'
Plug 'plasticboy/vim-markdown'

call plug#end()
" ---------------------------------------------------------------
color snazzy
let g:SnazzyTransparent = 1

" coc plug list:
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp', 'coc-marketplace', 'coc-clangd']

" ========== compile and run ==========
map <LEADER>r :call CompileAndRun()<CR>
func! CompileAndRun() 
  exec "w"
  if &filetype == 'cpp'
    set splitbelow
    exec "!g++ -std=c++17 % -Wall -o %<"
    :sp
    :res -10
    :term ./%< && rm ./%<
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunction

" ==== somathing coc config =====
"

xnoremap * :<C-u>call <SID>VsetSearch('/')<CR>/<C-R>=@/<CR><CR>
function! s:VsetSearch(cmdtype) 
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

set updatetime=100
set shortmess+=c
" buffer
set hidden

" coc lsp use tab 
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
 
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" show next/prev error
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>+ <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <LEADER>h to show documentation in preview window.
nnoremap <silent> <LEADER>? :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)


" nerdcommenter config -------------------------------------------
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" ----------------------------------------

" nerdtree config -----------------------
" nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <LEADER>n :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
" ------------------------------------
" ========== clangd ==========
"" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

" ========== telescope(file finder) ==========
nnoremap ;f <cmd>Telescope find_files<cr>
nnoremap tf :tabe<CR>:Telescope find_files<cr>
map ;F sl<cmd>Telescope find_files<cr>
nnoremap ;g <cmd>Telescope live_grep<cr>
nnoremap ;G :tabe<CR>:Telescope live_grep<cr>
nnoremap ;b <cmd>Telescope buffers<cr>
nnoremap ;h <cmd>Telescope help_tags<cr>

" test
" resize the split window
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" ===
" === markdown
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']

" ===
" === tagbar config
" ===
"不显示文档总字数
let g:airline#extensions#wordcount#enabled = 0
"不显示文件编码（Windows系统）
let g:airline#parts#ffenc#skip_expected_string='utf-8[dos]'
"设置tagber对于markdown的支持
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Chapter',
        \ 'i:Section',
        \ 'k:Paragraph',
        \ 'j:Subparagraph'
    \ ]
\ }
"取消显示warning部分
let g:airline_section_warning = ''
"取消显示section_b
let g:airline_section_b = ''
"section_c显示为tagbar检索出来的标题
let g:airline_section_c = airline#section#create(['tagbar'])
"section_x显示文件名
let g:airline_section_x = '%{expand("%")}'
"section_y显示时间
let g:airline_section_y = airline#section#create(['%{strftime("%D")}'])
"section_z显示日期
let g:airline_section_z = airline#section#create(['%{strftime("%H:%M")}'])
"激活tagbar扩展
let g:airline#extensions#tagbar#enabled = 1


" ===
" === markdonw vim
" ===

let g:vim_markdown_math = 1

let g:vim_markdown_folding_disabled = 1

let g:vim_markdown_folding_level = 6

let g:vim_markdown_toc_autofit = 1

let g:vim_markdown_folding_style_pythonic = 1


" === 
" === fold 
" === 
"
set foldmethod=indent
set foldlevelstart=10086

