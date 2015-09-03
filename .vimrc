scriptencoding utf-8

" Install vim-plug if not already installed
if has("user_commands")
    let vim_plug_source_file=expand('~/.vim/autoload/plug.vim')
    if !filereadable(vim_plug_source_file)
        echo "Installing vim-plug plugin manager..."
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall
    endif
endif

syntax on " enable syntax-highlighting

" GUI and Terminal VIM options {{{
if has("gui_running")
    " Disable all GUI elements and enable console based dialogs for simple queries
    set guioptions=gc
    " Default font for GUI Vim
    set guifont=DroidSansMonoForPowerlinePlusNerdFileTypesPlusPomicons:h13
else
    set t_Co=256
    if exists('$TMUX')
        let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
        let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
        set t_ut=
    else
        let &t_SI = "\<Esc>]50;CursorShape=1\x7"
        let &t_EI = "\<Esc>]50;CursorShape=0\x7"
    endif
endif
" }}}

" Mouse {{{
if has('mouse')
    set mouse=a " Enable mouse support
    set mousemodel=popup " Use the mouse for copy/paste with popup in gui vim
    set mousehide " Hide cursor while typing
    if exists("$TMUX")
        if has('nvim')
        else
            " Tmux knows the extended mouse mode
            set ttymouse=xterm2
        endif
    endif
endif
" }}}

" Multibyte {{{
if has('multi_byte')
    set listchars=trail:·,tab:»·,eol:¶,extends:→,precedes:←,nbsp:×
    " Vertical split chars
    set fillchars=stl:\ ,stlnc:\ ,vert:│
    if has("linebreak")
          let &sbr = nr2char(8618).' ' " Show ↪ at the beginning of wrapped lines
    endif
endif
" }}}

" Autocmd {{{
if has("autocmd")
    " Enable file type detection.
    filetype plugin indent on

    " Python indentation
    " About nosmartindent please look this link
    " http://stackoverflow.com/questions/2063175/vim-insert-mode-comments-go-to-start-of-line
    au FileType python setl nosmartindent tw=79 wrap linebreak nolist

    " JavaScript indentation
    au FileType javascript setlocal expandtab shiftwidth=2 tabstop=2
    au FileType vim setlocal expandtab shiftwidth=2 tabstop=2

    " Remember cursor position
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif
" }}}

" Use ag over grep {{{
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
endif
" }}}

" Store undofile in to fixed location {{{
if exists("+undofile")
    " undofile - This allows you to use undos after exiting and restarting
    " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
    " :help undo-persistence
    " This is only present in 7.3+
    set undofile

    " Store undo files in to fixed location
    set undodir=/var/tmp//,/tmp//,.
endif
" }}}

" Store swap files in to fixed location
set noswapfile
set directory=/var/tmp//,/tmp//,.

" Store backup files in to fixed location
set nobackup
set backupdir=/var/tmp//,/tmp//,.

" This will set your path variable to current directory
" (from which you launched vim) and to all directories
" under current directory recursively.
set path=.,,**

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

" Disable timeout for Esc key
set ttimeout ttimeoutlen=0 notimeout
set ttyfast " Optimize for fast terminal connections
set lazyredraw " Don't redraw while executing macros (good performance config)

" Autocomplete options:
" longest: do not select the first candidate
" preview: removed includes display of documentation
set completeopt=menuone,longest

set confirm " Get a dialog when :q, :w, or :wq fails

let mapleader = "," " Map leader

let maplocalleader = "_" " Local leader

set hlsearch " Highlight search terms (very useful!)

set incsearch " Show search matches while typing

set display+=lastline " Display lastline instead of @

set laststatus=2 " Enable statusline

set magic " For regular expressions turn magic on

set ignorecase " Searches are Non Case-sensitive

set smartcase " Do smart case matching when searching

set showcmd " Show incomplete cmds down the bottom

set title " Show title

set acd " Vim will change the current working directory whenever you open a file

set autoread " Reload files changed outside automatically

" Use space instead of tab
set tabstop=4 shiftwidth=4 expandtab

set backspace=2 " Make backspace work like most other apps

set smarttab " Be smart when using tabs

set autoindent " Enable auto indent

set smartindent " Smart indent

set wrap " Enable word wrap

set noerrorbells visualbell t_vb= " No annoying sound on errors

set encoding=utf8 " Default encoding

set termencoding=utf-8 " Terminal encoding

set fileencodings=utf8,cp1251 " Supported file encodings

set number " Enable line numbers

set ruler " Always display cursor position

set hidden " A buffer becomes hidden when it is abandoned

set noautochdir " Change the current working directory whenever you open a file

set wildmenu " Turn on the Wild menu

set wildmode=list:longest,list:full " Wildmenu configuration

set wildignore+=*.o,*.pyc,*.jpg,*.png,*.gif,*.db,*.obj,.git " Ignore compiled files

set conceallevel=2 " Conceal level

set modelines=1 " Make Vim only use folding settings for current file

call plug#begin('~/.vim/plugged')

" Lean & mean status/tabline for vim that's light as air
Plug 'bling/vim-airline'

" Plug to toggle, display and navigate marks
Plug 'kshenoy/vim-signature'

" Icons support
" Adds font icons (glyphs ★♨☢) to programming languages,
" libraries, and web developer filetypes for:
" NERDTree, vim-airline, ctrlp, unite, lightline.vim, vimfiler, and flagship
Plug 'ryanoasis/vim-devicons'

" An extensible & universal comment vim-plugin that also handles embedded
" filetypes
Plug 'tomtom/tcomment_vim'

" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" Plug which shows a git diff in the gutter (sign column)
" and stages/reverts hunks.
Plug 'airblade/vim-gitgutter'

" a Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" Jedi for comfortable development with python
" TODO: jedi 0.9.0 library has issue with imports
" I'll fix this issue by using stable jedi version (0.8.1):
Plug 'davidhalter/jedi-vim', {'do': 'cd jedi/ && git checkout 7b402d7'}

" A nicer Python indentation style for vim.
Plug 'hynek/vim-python-pep8-indent'

" Color scheme
Plug 'jonathanfilip/vim-lucius'

" Javascript indenter (HTML indent is included)
Plug 'lukaszb/vim-web-indent'

" Aliev scripts collection for comfortable work (Bclose with confirm)
Plug 'aliev/vim-comfortable'

" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'

" A plugin of NERDTree showing git status
Plug 'Xuyuanp/nerdtree-git-plugin'

" A command-line fuzzy finder written in Go
Plug 'junegunn/fzf', {'do': 'yes \| ./install'}

" Plug to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'

" Improvement over standard matchparen plugin
Plug 'vim-scripts/matchparenpp'

" True Sublime Text style multiple selections for Vim
Plug 'terryma/vim-multiple-cursors'

" Vim plugin that allows you to visually select increasingly larger regions of
" text using the same key combination.
Plug 'terryma/vim-expand-region'

" Improved incremental searching for Vim
Plug 'haya14busa/incsearch.vim'

"Buffer bye (:Bdelete)
"Plugin 'moll/vim-bbye'

" Vim to REPL
Plug 'jpalardy/vim-slime'

" Vim and tmux integration
Plug 'christoomey/vim-tmux-navigator'

" Autoclose strings
Plug 'tpope/vim-surround'

" Jinja2 syntax
Plug 'Glench/Vim-Jinja2-Syntax'

" Autoclose pair symbols 
Plug 'Raimondi/delimitMate'

call plug#end()

" | Fugitive.vim | {{{
set diffopt+=vertical
" }}}

" | vim-airline | {{{
let g:airline_powerline_fonts = 1 " Use airline fonts
" If you want to auto-completion to work stable in older vim, disable this option
let g:airline#extensions#tabline#enabled = 1
" Airline tabline settings
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_section_c = '%t'
" }}}

" | jedi-vim | {{{
let g:jedi#popup_on_dot = 1
" let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 0
" let g:jedi#smart_auto_mappings = 0
" }}}

" | indentLine | {{{
" Make indent line faster
let g:indentLine_faster=1
" IndentLine character For use this feature please install patched font from repository root
let g:indentLine_char= '│'
" }}}

" | vim-devicons | {{{
let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" }}}

" | syntastic | {{{
" Syntax check mode for python (pip install pylama)
let g:syntastic_python_checkers = ['flake8', 'pylint']

" Syntax check mode for javascript (npm install jslint)
let g:syntastic_javascript_checkers = ['jslint']

" Make syntastic auto update the location list and make it also check
" when the file opens
let g:syntastic_always_populate_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=0
" }}}

" | nerdtree | leader+e, leader+E{{{
let NERDTreeMinimalUI = 1
let NERDTreeIgnore = ['\.pyc$']

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
nnoremap <silent> <Leader>E :NERDTreeFind<CR>
" }}}

" | ultisnips | {{{
let g:UltiSnipsJumpForwardTrigger='<tab>'
" }}}

" | incsearch.vim | / ? g/ n N * # g* g# | {{{
let g:incsearch#auto_nohlsearch = 1

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
" }}}

" | vim-gitgutter | {{{
let g:gitgutter_max_signs=10000

" | Goto file with line number under cursor | gf | {{{
nnoremap gf gF
" }}}

" | 'F7' spell check toggle | {{{
map <F7> :setlocal spell! spelllang=en_us,ru_ru<CR>
" }}}

" | Paste multiple lines | y, p | {{{
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]
" }}}

" | List toggle | leader+l | {{{
nnoremap <silent> <Leader>l :set list!<CR>
" }}}

" | Close the current buffer and move to the previous one | leader+w | {{{
nnoremap <silent> <leader>w :bp <BAR> bd #<CR>}}}"
" }}}

" | Quickly jump by declarations list | :BTags |{{{
nnoremap <silent> <Leader>s :BTags<CR>
" }}}

" | Buffer list | leader+b | {{{
nnoremap <silent> <Leader>b :BList<CR>
" }}}

" | Open files in splits | leader+f, leader+v | {{{
nnoremap <silent> <Leader>f :call fzf#run({
\   'down': '40%',
\   'sink': 'e' })<CR>

nnoremap <silent> <Leader>v :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>
" }}}

" | Search word under cursor by using Ag | leader + a | {{{
noremap <silent><Leader>a :Ag <C-R>=expand("<cword>")<CR><CR>
" }}}

" | Color options | {{{
set background=dark
try
    colors lucius
catch /^Vim\%((\a\+)\)\=:E185/
endtry

" Disable colors for folding column
hi FoldColumn ctermbg=NONE guibg=NONE

" Sign colors
hi! link SignColumn FoldColumn
" Disable background and foreground for vertical split
hi vertsplit ctermbg=NONE guibg=NONE
hi! link Folded ColorColumn
hi! link Error SpellBad
" }}}

" | Vim-slime | {{{
let g:slime_target = "tmux"
let g:slime_python_ipython = 1
" }}}

set noshowmode " Suppress mode change messages

" vim:foldmethod=marker:foldlevel=0
" set foldmethod=indent " Folding method by default
" set foldlevel=3 " Folding level
" vim:foldmethod=marker:foldlevel=0:tabstop=2:shiftwidth=2
