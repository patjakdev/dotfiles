packloadall
helptags ~/.vim/pack

syntax on

" Color scheme
set background=light
let g:solarized_termcolors=256
colorscheme solarized

"Tabs
filetype indent plugin on
set shiftwidth=4    " Reindent width (<< >>)
set tabstop=4       " Columns to a tab for display purposes
set softtabstop=4   " Columns used when hitting Tab in Insert mode
set expandtab       " Tab key = spaces in Insert mode
set smarttab        " Insert/delete blanks in front of a line according to
                    " shiftwidth instead of tabstop
set cinoptions=(4,t0,l1,:0

" Python doesn't do well with smartindent
autocmd FileType python set nosmartindent

"Search
set ignorecase      " Ignore case in search patterns and in tags file
set smartcase       " If search pattern has uppercase, search case-sensitively
set incsearch       " Turn on incremental search
"set hlsearch        " Highlight search matches

"Brackets
set showmatch       " Highlights the matching bracket

"Splits
set splitright
set splitbelow
nnoremap <silent> <Leader>= :resize +5<CR>
nnoremap <silent> <Leader>- :resize -5<CR>

"Columns
set colorcolumn=+1
set tw=80
set formatoptions+=t

"Breaking
let &showbreak = "↪>\ "
set breakindent
set linebreak

"Scrolling
set scrolloff=5     " Keeps at least five lines above/below current line
set sidescroll=1

"Other
set showcmd
set number          " Line numbers
set ruler           " Show row, column on the status line
set nocompatible
set title           " Show filename in console title
set tags=tags;/     " Searches for tags files in parent directories
set laststatus=2    " Keeps statusline showing at all times
set cmdheight=2     " Command bar is two rows high
set wildmenu        " Tab-completions appear as a menu
set spell spelllang=en_us
set backspace=2     " Make backspace work like you might imagine it would

"CScope
if has("cscope")
    set cscopetag   " Use cscope and ctags for ctrl-]
    set csto=1      " Prefer ctags to cscope

    " Add any cscope database in the cwd
    if filereadable("cscope.out")
        cs add cscope.out
    endif

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

" Trailing whitespace
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

" Don't have an annoying delay after hitting escape
set timeoutlen=1000 ttimeoutlen=0

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

"   ___                        _
"  / _ \ _   _ _ __ ___  _   _| | ___
" | | | | | | | '_ ` _ \| | | | |/ _ \
" | |_| | |_| | | | | | | |_| | | (_) |
"  \__\_\\__,_|_| |_| |_|\__,_|_|\___/

autocmd BufRead,BufNewFile *.h,*.c set filetype=c

set makeprg=build

let g:neomake_build_all_maker = {
    \ 'exe': 'build',
    \ 'args': ['--flavor=debug', '--keep-going'],
    \ }

let g:neomake_build_tags_maker = {
    \ 'exe': 'build',
    \ 'args': ['tags'],
    \ }

let g:neomake_c_gen_maker = {
    \ 'exe': 'adt/adt_gen.py',
    \ 'args': ['generate', '%'],
    \ 'append_file': 0,
    \ }

let g:neomake_c_build_maker = {
    \ 'exe': 'qonstruct/cc.py',
    \ 'args': ['--flavor', 'debug_plain', 'proof', '%'],
    \ 'append_file': 0,
    \ }

let g:neomake_c_lint_maker = {
    \ 'exe': 'lint/all',
    \ 'errorformat': '%f:%l: %m',
    \ 'args': ['%'],
    \ 'append_file': 0,
    \ }

let g:neomake_python_lint_maker = {
    \ 'exe': 'lint/all',
    \ 'args': ['%'],
    \ 'append_file': 0,
    \ }

let g:neomake_c_enabled_makers = ['gen', 'build', 'lint']
let g:neomake_python_enabled_makers = ['lint']
let g:neomake_enabled_makers = ['build_all', 'build_tags']
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_open_list = 2
let g:neomake_verbose = 2
let g:neomake_build_all_maker_buffer_output = 0

" Call NeoMake on file write
call neomake#configure#automake('w')
