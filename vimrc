execute pathogen#infect('bundle/{}', '~/src/tools/editors/vim/bundle/{}')

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

"Windows
set splitright
set splitbelow

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

"CtrlP
let g:ctrlp_user_command = ['.hg', 'hg --cwd %s locate -I .']
let g:ctrlp_lazy_update = 1

"SuperTab
let g:SuperTabDefaultCompletionType = "context"

"Powerline
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Signify
let g:signify_vcs_list = [ 'hg', 'git' ]

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

" Qumulo
" Build current associated test
function! QbuildT()
    let buffer = @%
    let regex = '\(.*\)test\.[ch]'
    if empty(matchstr(buffer, regex))
        let file_to_build = matchlist(buffer, '\(.*\)\.[ch]')[1] . '_test.list'
    else
        let file_to_build = matchlist(buffer, '\(.*\)\.[ch]')[1] . '.list'
    endif
    execute "Make build/debug/" . file_to_build
endfunction

" Build current .o file
function! QbuildO()
    let buffer = @%
    let file_to_build = matchlist(buffer, '\(.*\)\.[ch]')[1] . '.o'
    execute "Make build/debug/" . file_to_build
endfunction

command! MakeT call QbuildT()
command! MakeO call QbuildO()

nmap <F11> :MakeT<CR>
nmap <F12> :MakeO<CR>
