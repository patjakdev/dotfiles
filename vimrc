call pathogen#infect()
syntax on

" Color scheme
set background=light
let g:solarized_termcolors=256
colorscheme solarized

" Highlight tabs and trailing whitespace
:highlight ExtraWhitespace ctermbg=red
:match ExtraWhitespace /\s\+$\|\t\+/

" Tabs
set shiftwidth=4    " Reindent width (<< >>)
set tabstop=4       " Columns to a tab for display purposes
set softtabstop=4   " Columns used when hitting Tab in Insert mode
set expandtab       " Tab key = spaces in Insert mode
set smarttab        " Insert/delete blanks in front of a line according to
                    " shiftwidth instead of tabstop
set autoindent      " Copies indent from previous line when starting a new line
set smartindent     " Insert additional indents based on C syntax

"Search
set ignorecase      " Ignore case in search patterns and in tags file
set smartcase       " If search pattern has uppercase, search case-sensitively
set incsearch       " Turn on incremental search
"set hlsearch        " Highlight search matches

"Brackets
set showmatch       " Highlights the matching bracket
inoremap { {<CR>}<Esc>ko

"Other
set showcmd
set number          " Line numbers
set ruler           " Show row, column on the status line
set nocompatible
set scrolloff=5     " Keeps at least five lines above/below current line
set title           " Show filename in console title
set tags=tags;/     " Searches for tags files in parent directories
set laststatus=2    " Keeps statusline showing at all times
set colorcolumn=81  " Vertical colored line on column 81
