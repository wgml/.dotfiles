set nocompatible

call plug#begin('~/.config/nvim/plugged/')

" themes
Plug 'icymind/NeoSolarized'

" look and feel
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" productivity
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-commentary'

" git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" cpp
Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

" python
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
Plug 'ambv/black', { 'for': 'python' }

Plug 'w0rp/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" syntax highlighting
Plug 'sheerun/vim-polyglot'

" misc
Plug 'jremmen/vim-ripgrep'

Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
call plug#end()

set termguicolors
set background=light
colorscheme NeoSolarized
let g:airline_theme='solarized'

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

let mapleader=','

" use system clipboard
set clipboard+=unnamedplus

" save cursor position for file
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

set completeopt=menuone,noselect,preview,longest
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
set autoindent

" NERDTree
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

" airline
set encoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let airline#extensions#tabline#middle_click_preserves_windows = 1
nmap <C-S-Left>  <Plug>AirlineSelectPrevTab
nmap <C-S-Right> <Plug>AirlineSelectNextTab

" gitgutter
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_diff_base = 'HEAD'

" navigate splits

nnoremap <C-Left> <C-w><C-h>
nnoremap <C-Right> <C-w><C-l>
nnoremap <C-Up> <C-w><C-k>
nnoremap <C-Down> <C-w><C-j>

" vim-commentary
nmap <C-_> gcc <Down>
vmap <C-_> gc <Down>
autocmd FileType c,cpp,java,rs setlocal commentstring=//\ %s

" jedi
let g:jedi#goto_command = "<leader>b"
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = "<leader>u"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" ale
let g:ale_fixers = {'sh': ['shellcheck'], 'python': ['black']}
let g:ale_linters = {'sh': ['shellcheck'], 'cpp': ['clang', 'clangd'], 'perl': 'perl', 'python': ['flake8']}
let g:ale_linters_explicit = 1
let g:ale_completion_enabled = 0

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete = 1
let g:deoplete#sources = {'_': ['ale']}
