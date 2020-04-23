" Setting some decent VIM settings for programming
" This source file comes from git-for-windows build-extra repository (git-extra/vimrc)

ru! defaults.vim                " Use Enhanced Vim defaults
set mouse=                      " Reset the mouse setting from defaults
aug vimStartup | au! | aug END  " Revert last positioned jump, as it is defined below
let g:skip_defaults_vim = 1     " Do not source defaults.vim again (after loading this system vimrc)

colorscheme hybrid
syntax on

au GuiEnter * set t_vb=
set vb t_vb=      
set number        " �����к�
set vb t_vb=      " �رվ���������
set hlsearch      " �����������
set autoindent    " ���Զ�����
set tabstop=4     " ����tab���

set ai                          " set auto-indenting on for programming
set showmatch                   " automatically show matching brackets. works like it does in bbedit.
set vb                          " turn on the "visual bell" - which is much quieter than the "audio blink"
set laststatus=2                " make the last line where the status is two lines deep so you can see status always
set showmode                    " show the current mode
set clipboard=unnamed           " set clipboard to unnamed to access the system clipboard under windows
set wildmode=list:longest,longest:full   " Better command line completion

" һЩ�����ӳ��
let mapleader=','
let g:mapleader=','

" ʹ�� leader+w ֱ�ӱ���
inoremap <leader>w <Esc>:w<cr>

" ʹ�� jj ����normalģʽ
inoremap jj <Esc>`^

" use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" ��normalģʽ��ʹ�� - ɾ���ַ�
noremap - x

" ��normalģʽ��ʹ�� ctrl + d ɾ��һ��
noremap <C-d> dd

" ��normalģʽ��ʹ�ÿո���ѡ��һ������
noremap <space> viw
" ��visualģʽ��ʹ�� / ���ַ�����ת��Ϊ��д
vnoremap \ U


" ��insert ģʽ��ʹ��ӳ��ctrl + d ��ɾ��һ��
inoremap <c-d> <Esc>ddi



" Show EOL type and last modified timestamp, right after the filename
" Set the statusline
set statusline=%f               " filename relative to current $PWD
set statusline+=%h              " help file flag
set statusline+=%m              " modified flag
set statusline+=%r              " readonly flag
set statusline+=\ [%{&ff}]      " Fileformat [unix]/[dos] etc...
set statusline+=\ (%{strftime(\"%H:%M\ %d/%m/%Y\",getftime(expand(\"%:p\")))})  " last modified timestamp
set statusline+=%=              " Rest: right align
set statusline+=%l,%c%V         " Position in buffer: linenumber, column, virtual column
set statusline+=\ %P            " Position in buffer: Percentage

if &term =~ 'xterm-256color'    " mintty identifies itself as xterm-compatible
  if &t_Co == 8
    set t_Co = 256              " Use at least 256 colors
  endif
  set termguicolors           " Uncomment to allow truecolors on mintty
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'mhinz/vim-startify'

" Vim Theme
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'

" 
Plug 'bfrg/vim-cpp-modern'

Plug 'vim-airline/vim-airline'

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<c-p>'

Plug 'yggdroot/indentline'

Plug 'easymotion/vim-easymotion'
nmap ss <Plug>(easymotion-s2)

Plug 'scrooloose/nerdtree'
nnoremap <leader>v :NERDTreeFind<cr>
nnoremap <leader>g :NERDTreeToggle<cr>
let NERDTreeShowHidden=1

Plug 'tpope/vim-surround'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'brooth/far.vim'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 0 " ��

Plug 'tpope/vim-commentary'
Plug 'sbdchd/neoformat'

" vim latex config
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" Initialize plugin system
call plug#end()

"------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Set UTF-8 as the default encoding for commit messages
    autocmd BufReadPre COMMIT_EDITMSG,MERGE_MSG,git-rebase-todo setlocal fileencodings=utf-8

    " Remember the positions in files with some git-specific exceptions"
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$")
      \           && &filetype !~# 'commit\|gitrebase'
      \           && expand("%") !~ "ADD_EDIT.patch"
      \           && expand("%") !~ "addp-hunk-edit.diff" |
      \   exe "normal g`\"" |
      \ endif

      autocmd BufNewFile,BufRead *.patch set filetype=diff

      autocmd Filetype diff
      \ highlight WhiteSpaceEOL ctermbg=red |
      \ match WhiteSpaceEOL /\(^+.*\)\@<=\s\+$/
endif " has("autocmd")

