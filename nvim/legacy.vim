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

" no hidden buffers
set hidden&

" automatically read on change
set autoread

set termguicolors

let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" Transparent background
hi Normal guibg=NONE ctermbg=NONE

let g:cmake_link_compile_commands = 1

nnoremap <leader>cg :CMakeGenerate<CR>
nnoremap <leader>cb :CMakeBuild<CR>

" C-p: FZF find files
nnoremap <silent> <C-p> :Files<CR>

" C-g: FZF ('g'rep)/find in files
nnoremap <silent> <C-g> :Rg<CR>

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


let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_COMMAND = 'rg --files --ignore-case --hidden -g "!{.git,node_modules,vendor}/*"'
command! -bang -nargs=? -complete=dir Files
     \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"

function! OpenMarkdownPreview (url)
    execute "silent ! firefox --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

let g:matlab_panel_size = 50
let g:matlab_default_mappings='<F5>'


nnoremap <leader>ga <Plug>(GitGutterStageHunk)
nnoremap <leader>gu <Plug>(GitGutterUndoHunk)
nnoremap <leader>gs :Magit<CR>

set noswapfile

nnoremap <leader>e :Neotree toggle<CR>
let g:table_mode_corner='|'
