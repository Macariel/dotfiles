"dein Scripts-----------------------------
if &compatible
    set nocompatible
endif

" Required:
set runtimepath+=/home/pawelka/.vim/bundles/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/pawelka/.vim/bundles')
    call dein#begin('/home/pawelka/.vim/bundles')

    " Let dein manage dein
    " Required:
    call dein#add('/home/pawelka/.vim/bundles/repos/github.com/Shougo/dein.vim')

    " Add or remove your plugins here:
    call dein#add('Raimondi/delimitMate') " Autocompletion of parenthesis etc.
    call dein#add('nathanaelkane/vim-indent-guides') " Smart intedation
    call dein#add('vim-scripts/AnsiEsc.vim') " Show shell colors in vim
    call dein#add('JamshedVesuna/vim-markdown-preview') " CTRL-P opens a browser with a preview of the markdown
    call dein#add('rhysd/vim-gfm-syntax') " Highlights for github markdown

    " Required:
    call dein#end()
    call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
    call dein#install()
endif

"End dein Scripts-------------------------
set number " Personal vim settings
set wildmenu " set cursorline
set tabstop=4 " show existing tab with 4 spaces width
set shiftwidth=4 " when indenting with '>', use 4 spaces width
set expandtab " On pressing tab, insert 4 spaces
set timeoutlen=1000 ttimeoutlen=0 " Remove the 1sec delay when leaving the visual mode

" Bind F4 to highlight search results
:noremap <F4> :set hlsearch! hlsearch?<CR>

" Set the foreground and background colors for the highlighting of matching
" parenthesis
hi MatchParen cterm=none ctermbg=green ctermfg=black

" Vim Intent Guides Plugin
colorscheme default
let g:indent_guides_auto_colors = 0
let g:indent_guides_enable_on_vim_startup = 1
hi IndentGuidesEven ctermbg=234
set ts=4 sw=4 et

" save file shortcut to CTRL+S
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>
" save and exit
" inoremap <C-d> <esc>:wq!<cr>
" nnoremap <C-d> :wq!<cr>

" quit and discard changes with CTRL+Q
inoremap <C-q> <esc>:qa!<cr>
nnoremap <C-q> :qa!<cr>"

" Allow us to use Ctrl-s and Ctrl-q as keybinds in vim
silent !stty -ixon
" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" CLIPBOARD: Use the clipboard as the main source for copying and pasting
set clipboard=unnamedplus

" EASY COMMANDS. Introduce some commands which are easier to memorize than
" obscure vim commands
command Format :normal gg=G
command RemoveTrailingWhitespaces :%s/\s\+$//e

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Markdown config
:let vim_markdown_preview_github=1

" Use other colorscheme vor vimdiff because the default one is unreadable
if &diff
    colorscheme evening
endif
