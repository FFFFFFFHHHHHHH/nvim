
" === Auto load for first time uses
      

 lua require('basic')
" Packer插件管理
" lua require('plugins')
" 快捷键映射
lua require('keybindings')

" 皮肤设置
" https://github.com/ellisonleao/gruvbox.nvim
" set background=dark " or light if you want light mode
" colorscheme gruvbox

" 插件配置
"lua require('plugin-config/which-key')
"lua require('plugin-config/nvim-treesitter')
"lua require('plugin-config/telescope')
"lua require('plugin-config/nvim-autopairs')
"lua require('plugin-config/nvim-tree')
"lua require('plugin-config/bufferline')
"lua require('plugin-config/surround')
"lua require('plugin-config/comment')
"lua require('plugin-config/nvim-colorizer')
"lua require('plugin-config/rust-tools')
"
"" lsp
"lua require('lsp/nvim-cmp-config')
"lua require('lsp/diagnostic_signs')
"lua require('lsp/language_servers')
"
"
nnoremap < <<
nnoremap > >>
let mapleader=" "
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l 

" inoremap ' ''<ESC>i
" inoremap " ""<ESC>i
" inoremap ( ()<ESC>i
" inoremap () ()<ESC>a
" inoremap [ []<ESC>i

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

call plug#end()
" ---------------------------------------------------------------
color snazzy
let g:SnazzyTransparent = 1

" coc plug list:
let g:coc_global_extensions = ['coc-json', 'coc-vimlsp','coc-marketplace']

" somathing coc config:

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
"
" autopairs config ----------
"
" ------------------------------------------
