set nocompatible

call plug#begin('~/.config/nvim/plugged/')

" themes
Plug 'joshdick/onedark.vim'

" look and feel
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" productivity
Plug 'kien/ctrlp.vim'
Plug 'mbbill/undotree'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" dev
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer' }

" cpp
" Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rhysd/vim-clang-format'
" Plug 'Valloric/YouCompleteMe', {'frozen': 'true'}
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

Plug 'vim-syntastic/syntastic'
" tmux integration
Plug 'christoomey/vim-tmux-navigator'

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" misc
Plug 'jremmen/vim-ripgrep'

call plug#end()

colorscheme onedark

syntax on
set number

set autowrite
" highlight current line
set cursorline

" center cursor vertically
set scrolloff=10

" wrap between lines
set whichwrap+=<,>,h,l,[,]

set shell=sh

set mouse=a

set showmatch           " highlight matching [{()}]
set incsearch           " search as characters are entered
set hlsearch            " highlight matches

" set foldenable          " enable folding
" set foldmethod=syntax   " fold based on indent level
" set foldlevelstart=10   " open most folds by default

nnoremap <space> za

" background change for too long lines
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%120v.\+/

let mapleader=','

" use system clipboard
set clipboard+=unnamedplus

" save cursor position for file
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" NERDTree
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
let NERDTreeWinSize = 50
" close vim if the only window left open is a NERDTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nmap ,n :NERDTreeFind<CR>
nmap ,m :NERDTreeToggle<CR>

" whitespaces
set tabstop=2
set shiftwidth=2
set expandtab
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set list

" strip trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" YCM
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = '»'
let g:ycm_warning_symbol = '»'
let g:ycm_add_preview_to_completeopt = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_complete_in_comments_and_strings = 1
let g:ycm_autoclose_preview_window_after_completion = 1

nnoremap <C-f> :YcmCompleter FixIt<CR>
nnoremap <C-g> :YcmCompleter GoTo<CR>
nnoremap <leader>yg :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>yd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>yc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>yf :YcmCompleter FixIt<CR>
nnoremap <C-b> :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" airline
set encoding=utf-8
let g:airline_powerline_fonts = 1
" set guifont=Source\ Code\ Pro\ for\ Powerline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let airline#extensions#tabline#middle_click_preserves_windows = 1
nmap <C-S-Left>  <Plug>AirlineSelectPrevTab
nmap <C-S-Right> <Plug>AirlineSelectNextTab

" gitgutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_diff_base = 'HEAD'

" clang-format
map <C-A-l> :ClangFormat<CR>

" tagbar
nmap <F8> :TagbarToggle<CR>

" undo tree
nnoremap <F6> :UndotreeToggle<cr>

" jumping between sources and headers
nnoremap <F4> :call SourceHeaderJump()<CR>
nnoremap <S-F4> *:call SourceHeaderJump()<CR>n:noh<CR>

" navigate splits

nnoremap <C-Left> <C-w><C-h>
nnoremap <C-Right> <C-w><C-l>
nnoremap <C-Up> <C-w><C-k>
nnoremap <C-Down> <C-w><C-j>
" tmux navigator
" let g:tmux_navigator_no_mappings = 1
" let g:tmux_navigator_disable_when_zoomed = 1
" nnoremap <silent> <C-Left> :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-Right> :TmuxNavigateRight<cr>
" nnoremap <silent> <C-Up> :TmuxNavigateUp<cr>
" nnoremap <silent> <C-Down> :TmuxNavigateDown<cr>
"
" tmux integration
" nmap <C-s> :!tmux send-keys -t 0:1.1 icsync C-j <CR><CR>
" nmap <C-S-A-s> :!tmux send-keys -t 0:1.1 isell-rsync C-j <CR><CR>
" nmap <C-c> :!tmux send-keys -t 0:1.2 "cd /login/sg222576/git/isell/$(git rev-parse --abbrev-ref HEAD)/IC && ./ibuild All" C-j <CR><CR>

" vim-commentary
" <C-/> really
nmap <C-_> gcc <Down>
vmap <C-_> gc <Down>
autocmd FileType c,cpp,java,rs setlocal commentstring=//\ %s

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++17 -stdlib=libc++'
let g:syntastic_cpp_check_header = 1

" rust racer
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let g:racer_experimental_completer = 1
au FileType rust nmap <C-b> <Plug>(rust-def)
" au FileType rust nmap gs <Plug>(rust-def-split)
" au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap <C-S-b> <Plug>(rust-doc)

