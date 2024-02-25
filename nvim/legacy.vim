set number
set relativenumber
syntax on
set visualbell
set ruler
set nowrap
set splitright
set splitbelow

set so=10

" faster updates!
set updatetime=100

" nnoremap <leader>p :lua require("nabla").popup()<CR> 
" Customize with popup({border = ...})  : `single` (default), `double`, `rounded`
" nnoremap q: <nop>
" Remove {} motions from jump list
nnoremap <silent> } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap <silent> { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>
" no hidden buffers
set hidden&

" automatically read on change
set autoread

set termguicolors

" colorscheme tokyonight-night
colorscheme catppuccin-mocha

" Transparent background
" hi Normal guibg=NONE ctermbg=NONE
" hi NormalNC guibg=NONE ctermbg=NONE
" hi Comment guibg=NONE ctermbg=NONE
" hi Constant guibg=NONE ctermbg=NONE
" hi Special guibg=NONE ctermbg=NONE
" hi Identifier guibg=NONE ctermbg=NONE
" hi Statement guibg=NONE ctermbg=NONE
" hi PreProc guibg=NONE ctermbg=NONE
" hi Type guibg=NONE ctermbg=NONE
" hi Underlined guibg=NONE ctermbg=NONE
" hi Todo guibg=NONE ctermbg=NONE
" hi String guibg=NONE ctermbg=NONE
" hi Function guibg=NONE ctermbg=NONE
" hi Conditional guibg=NONE ctermbg=NONE
" hi Repeat guibg=NONE ctermbg=NONE
" hi Operator guibg=NONE ctermbg=NONE
" hi Structure guibg=NONE ctermbg=NONE
" hi LineNr guibg=NONE ctermbg=NONE
" hi NonText guibg=NONE ctermbg=NONE
" hi SignColumn guibg=NONE ctermbg=NONE
" hi CursorLineNr guibg=NONE ctermbg=NONE
" hi EndOfBuffer guibg=NONE ctermbg=NONE

" hi NormalFloat guibg=NONE ctermbg=NONE
" hi NeoTreeNormal guibg=NONE ctermbg=NONE
" hi NeoTreeNormalNC guibg=NONE ctermbg=NONE
" hi TelescopeBorder guibg=NONE ctermbg=NONE
" hi TelescopeNormal guibg=NONE ctermbg=NONE

" hi TroubleCount guibg=NONE ctermbg=NONE
" hi TroubleError guibg=NONE ctermbg=NONE
" hi TroubleNormal guibg=NONE ctermbg=NONE
" hi TroubleTextInformation guibg=NONE ctermbg=NONE
" hi TroubleSignWarning guibg=NONE ctermbg=NONE
" hi TroubleLocation guibg=NONE ctermbg=NONE
" hi TroubleWarning guibg=NONE ctermbg=NONE
" hi TroublePreview guibg=NONE ctermbg=NONE
" hi TroubleTextError guibg=NONE ctermbg=NONE
" hi TroubleSignInformation guibg=NONE ctermbg=NONE
" hi TroubleIndent guibg=NONE ctermbg=NONE
" hi TroubleSource guibg=NONE ctermbg=NONE
" hi TroubleSignHint guibg=NONE ctermbg=NONE
" hi TroubleSignOther guibg=NONE ctermbg=NONE
" hi TroubleFoldIcon guibg=NONE ctermbg=NONE
" hi TroubleTextWarning guibg=NONE ctermbg=NONE
" hi TroubleCode guibg=NONE ctermbg=NONE
" hi TroubleInformation guibg=NONE ctermbg=NONE
" hi TroubleSignError guibg=NONE ctermbg=NONE
" hi TroubleFile guibg=NONE ctermbg=NONE
" hi TroubleHint guibg=NONE ctermbg=NONE
" hi TroubleTextHint guibg=NONE ctermbg=NONE
" hi TroubleText guibg=NONE ctermbg=NONE

" hi FoldColumn guibg=NONE ctermbg=NONE
" hi Folded guibg=#202330
" hi TreesitterContext guibg=#202330
" hi TreesitterContextBottom gui=underline

let g:cmake_link_compile_commands = 1

nnoremap <leader>cg :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild<CR>

" " C-p: FZF find files
" nnoremap <silent> <C-p> :Files<CR>
"
" " C-g: FZF ('g'rep)/find in files
" nnoremap <silent> <C-g> :Rg<CR>

" Function to set tab width to n spaces
function! SetTab(n)
  let &tabstop=a:n
  let &shiftwidth=a:n
  let &softtabstop=a:n
  set expandtab
  set autoindent
  set smartindent
endfunction

command! -nargs=1 SetTab call SetTab(<f-args>)

:SetTab 4

" Function to trim extra whitespace in whole file
function! Trim()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfun

command! -nargs=0 Trim call Trim()

set laststatus=2

" Highlight search results
set hlsearch
set incsearch

set t_Co=256

" colorcolumn 80 when opening C/C++
autocmd BufRead,BufNewFile *.c SetTab 4
autocmd BufRead,BufNewFile *.h SetTab 4
autocmd BufRead,BufNewFile *.cpp SetTab 4
autocmd BufRead,BufNewFile *.hpp SetTab 4

" C/C++ indent options: fix extra indentation on function continuation
set cino=(0,W4
"
" disable backup files
set nobackup
set nowritebackup

set shortmess+=c

set signcolumn=yes


" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
" let g:fzf_colors =
" \ { 'fg': ['fg', 'Normal'],
" \ 'bg': ['bg', 'Normal']}
"
" let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
" command! -bang -nargs=? -complete=dir Files
"      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

function! OpenMarkdownPreview (url)
    execute "silent ! firefox --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

let g:matlab_panel_size = 50
let g:matlab_default_mappings='<F5>'


set noswapfile


let g:table_mode_corner='|'

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun


let R_external_term = "tmux split -h"

au BufNewFile,BufRead *.wgsl set filetype=wgsl
