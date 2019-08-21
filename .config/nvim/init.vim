call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'valloric/youcompleteme'
Plug 'kien/ctrlp.vim'
Plug 'raimondi/delimitmate'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'christoomey/vim-tmux-navigator'
Plug 'chriskempson/base16-vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'scrooloose/syntastic'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

" Have NERDTree show hidden files by default.
let NERDTreeShowHidden = 0

" Close vim when NERDTree is the only buffer open.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Have airline show buffers open if there is only a single tab.
let g:airline#extensions#tabline#enabled = 1

let g:deoplete#enable_at_startup = 1

" Set hybrid relative numbers.
set number relativenumber

" Every tab is 4 spaces.
set tabstop=4 shiftwidth=4 expandtab

" Set the timeout after esc is pressed.
set timeoutlen=1000 ttimeoutlen=0

" Syntastic settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" Start NERDTree if no file was specified when nvim runs.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Have NERDTree toggle with CTRL+n
map <C-n> :NERDTreeToggle<CR>

" Have the base16 theme plugin use 256 colors.
let base16colorspace=256

" Have the base16 theme plugin use the theme specified in the .vimrc_background file.
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif

" Fix a bug where the VIM tmux plugin doesn't allow you to switch to screens
" on the left using CTRL+h.
nnoremap <silent> <BS> :TmuxNavigateLeft<cr>

" Disable YCM from showing the preview window after completions are made.
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" Automatically load .ycm_extra_conf files if they are available.
let g:ycm_confirm_extra_conf = 1

" Set the global .ycm_extra_conf file path.
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" Basic VIM options.
set autoindent
set backspace=indent,eol,start
set smarttab

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline
set nowrap

set autowrite

" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
endif

" Disable the F1 key (help)
nmap <F1> <nop>

set tabstop=2
set shiftwidth=2
