set t_Co=256

call plug#begin('~/.vim/plugged')

Plug 'habamax/vim-godot'

" Use release branch (recommend)
Plug 'vim-syntastic/syntastic'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'itchyny/lightline.vim'

Plug 'mengelbrecht/lightline-bufferline'

Plug 'skywind3000/asyncrun.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'pseewald/vim-anyfold'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries'  }

Plug 'rust-lang/rust.vim'

Plug 'mileszs/ack.vim'

Plug 'Rigellute/shades-of-purple.vim'

Plug 'itchyny/calendar.vim'

" Below is Hopin related

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

call plug#end()

" use ripgrep w/ ack

" Use ripgrep for searching ⚡️
" Options include:
" --vimgrep -&gt; Needed to parse the rg response properly for ack.vim
" --type-not sql -&gt; Avoid huge sql file dumps as it slows down the search
" --smart-case -&gt; Search case insensitive if all lowercase pattern, Search case sensitively otherwise
let g:ackprg = 'rg --vimgrep --type-not sql --smart-case'

" Auto close the Quickfix list after pressing '&lt;enter&gt;' on a list item
let g:ack_autoclose = 1

" Any empty ack search will search for the work the cursor is on
let g:ack_use_cword_for_empty_search = 1

" Don't jump to first match
cnoreabbrev Ack Ack!

" Maps &lt;leader&gt;/ so we're ready to type the search keyword
nnoremap &lt;Leader&gt;/ :Ack!&lt;Space&gt;
" }}}

" Navigate quickfix list with ease
nnoremap &lt;silent&gt; [q :cprevious&lt;CR&gt;
nnoremap &lt;silent&gt; ]q :cnext&lt;CR&gt;</code>



" " Godot fold attempts

setlocal foldlevel=0
autocmd Filetype gdscript AnyFoldActivate 
" 
" func! GodotSettings() abort
"     setlocal foldmethod=expr
"     setlocal tabstop=4
"     nnoremap <buffer> <F4> :GodotRunLast<CR>
"     nnoremap <buffer> <F5> :GodotRun<CR>
"     nnoremap <buffer> <F6> :GodotRunCurrent<CR>
"     nnoremap <buffer> <F7> :GodotRunFZF<CR>
" endfunc
" augroup godot | au!
"     au FileType gdscript call GodotSettings()
" augroup end


" dope custom mappings

noremap <SPACE> <Nop>
let mapleader = "\\"
map <leader>t :to term<CR>
map <leader>jt :bo term<CR>


" coc stuff
"
"

let g:coc_global_extensions = ['coc-solargraph']

highlight CocFloating ctermbg=black ctermfg=magenta

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

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

" end coc stuff

:let g:NERDTreeWinSize=60

function! <SID>GDScriptFormat()
    let l = line(".")
    let c = col(".")
    :%! gdformat -
    call cursor(l, c)
endfunction

autocmd BufWritePre *.gd :call <SID>GDScriptFormat()

set number

" lightline
let g:lightline = {
      \ 'colorscheme': 'deus',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ 'component_function': {
      \   'filetype': 'MyFiletype',
      \   'fileformat': 'MyFileformat',
      \   'gitbranch': 'FugitiveHead'
      \ }
      \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction


let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#enable_nerdfont = 1


" snipmate legacy fix

let g:snipMate = { 'snippet_version' : 1  }

