" Airline
let g:airline_powerline_fonts = 1 " Must be set before plugin is loaded

packloadall
helptags ~/.vim/pack

" Airline
let g:airline_theme = 'solarized'

let g:airline_symbols.linenr = ''
let g:airline_symbols.maxlinenr = ''
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'c'  : 'C',
      \ 'i'  : 'I',
      \ 'ic' : 'I',
      \ 'ix' : 'I',
      \ 'n'  : 'N',
      \ 'ni' : 'N',
      \ 'no' : 'N',
      \ 'R'  : 'R',
      \ 'Rv' : 'V-REPLACE',
      \ 's'  : 'S',
      \ 'S'  : 'S-LINE',
      \ '' : 'S-BLOCK',
      \ 't'  : 'T',
      \ 'v'  : 'V',
      \ 'V'  : 'V-LINE',
      \ '' : 'V-BLOCK',
      \ }

call airline#parts#define('neomake', {'function': 'BuildStatus'})
let g:airline_section_a = airline#section#create_left([
        \'mode', 'crypt', 'paste', 'keymap', 'capslock', 'xkblayout', 'iminsert']) " Removed spell
let g:airline_section_x = '' " Normally file type
let g:airline_section_y = airline#section#create(['neomake']) " Normally encoding
let g:airline_section_z = airline#section#create(['windowswap', 'obsession', 'linenr', 'maxlinenr', ':%3v'])

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
    \ 'args': ['--flavor', 'debug', 'generate', '%'],
    \ 'append_file': 0,
    \ }

let g:neomake_c_build_maker = {
    \ 'exe': 'qonstruct/cc.py',
    \ 'args': ['--flavor', 'debug', 'proof', '%'],
    \ 'append_file': 0,
    \ }

let g:neomake_c_lint_maker = {
    \ 'exe': 'lint/c/__main__.py',
    \ 'errorformat': '%f:%l: %m',
    \ 'args': ['%'],
    \ 'append_file': 0,
    \ }

let g:neomake_python_lint_maker = {
    \ 'exe': 'lint/py/__main__.py',
    \ 'args': ['%'],
    \ 'append_file': 0,
    \ }

let g:neomake_c_enabled_makers = ['gen', 'build', 'lint']
let g:neomake_python_enabled_makers = ['lint']
let g:neomake_enabled_makers = ['build_all', 'build_tags']
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_open_list = 2
let g:neomake_build_all_maker_buffer_output = 0

call neomake#configure#automake('w') " Call Neomake on file write

function! HandleBuildFinished()
    for job in g:neomake_hook_context.finished_jobs
        if job.exit_code != 0
            let b:build_status = ''
            return
        endif
    endfor

    let b:build_status = ''
endfunction

function! HandleJobInit()
    let b:build_status = 'Building...'
endfunction

function! BuildStatus()
    return get(b:, 'build_status', '')
endfunction

augroup neomake_hooks
    au!
    autocmd User NeomakeJobInit :call HandleJobInit()
    autocmd User NeomakeFinished :call HandleBuildFinished()
augroup END
