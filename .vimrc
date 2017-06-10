"""""""""""""""""""""""
" Vundle configuration:
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
" :BundleInstall to install bundles
" sudo apt-get install python-rope
"   or
" sudo port install py27-rope
" Change mappings:
" vim ~/.vim/bundle/crunch/plugin/crunch.vim
" cd ~/.vim/bundle/YouCompleteMe
" ./install.sh --clang-completer
"   or
" vim-youcompleteme
" echo "snippet deb" >> ~/.vim/bundle/vim-snippets/snippets/python.snippets
" echo -e '\tprint "DEBUG: ${1:foo}: %s" % $1' >> ~/.vim/bundle/vim-snippets/snippets/python.snippets
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

" Let Vundle manage Vundle
Bundle 'VundleVim/Vundle.vim'
" csv editing
Bundle 'chrisbra/csv.vim'
" molokai color scheme
Bundle 'tomasr/molokai'
" Custom python in ~/.vim/bundle/snipmate.vim/snippets/python-custom.snippets
Bundle 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
" ctrl-p plugin for fuzzy file searching
Bundle 'kien/ctrlp.vim'
" Open files in existing split instead of jumping to existing one
let g:ctrlp_switch_buffer = 0
" Nerd tree
Bundle 'scrooloose/nerdtree'
" Nerd commenter
" Usage:
" <leader>ci # invert comment
" <leader>c<space> # toggle comment
Bundle 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1

" vim-airline statusbar plugin
Bundle 'bling/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
" Gives the tabs menu at the top
let g:airline#extensions#tabline#enabled = 1
" Disabled because it interferes with vim-fugitive and causes slowness
let g:airline#extensions#branch#enabled = 0
let g:airline_theme = 'powerlineish'
" Control fancy font stuff.  disable powerline fonts unless patched fonts are
" installed a la: https://powerline.readthedocs.org/en/latest/fontpatching.html
" Invert what lines are commented in the following lines to switch
" let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" Remove 'mode' from statusline
let g:airline_section_a = ''
" Remove (tagbar, filetype, virtualenv)
let g:airline_section_x = ''
" Remove file encoding and fileformat
let g:airline_section_y = ''


Bundle 'Valloric/ListToggle'
let g:lt_location_list_toggle_map = '<leader>L'
let g:lt_quickfix_list_toggle_map = '<leader>Q'
Bundle 'jlanzarotta/bufexplorer'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-repeat'
" Can cause peformance issues
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-git'
Bundle 'othree/eregex.vim'
" Only use eregex with configured <leader>/
let g:eregex_default_enable = 0
Bundle 'python-rope/ropevim'
Bundle 'python-rope/ropemode'
" Diff changes between last buffer and saved file
Bundle 'jmcantrell/vim-diffchanges'
" Diff changes between swap file and saved file
Bundle 'chrisbra/Recover.vim'
" calculator plugin
Bundle 'arecarn/crunch'
Bundle 'vim-scripts/hexman.vim'
Bundle 'godlygeek/tabular'
" Autoreads files automatically when they change
Bundle 'Carpetsmoker/auto_autoread.vim'
call vundle#end()
filetype plugin on


"""""""""""""""""""""""
" Add work specific vimrc
"""""""""""""""""""""""
if filereadable(expand('~/.vimrc.work'))
  source ~/.vimrc.work
else
  Bundle 'Valloric/YouCompleteMe'
endif

"""""""""""""""""""""""
"""""""""""""""""""""""
" Custom functions
"""""""""""""""""""""""
"""""""""""""""""""""""
" thanks to http://vimcasts.org/e/4
" Strip trailing whitespace mapped below
function! Strip_trailing()
  let previous_search=@/
  let previous_cursor_line=line('.')
  let previous_cursor_column=col('.')
  %s/\s\+$//e
  let @/=previous_search
  call cursor(previous_cursor_line, previous_cursor_column)
endfunction
"""""""""""""""""""""""
"""""""""""""""""""""""
" YCM doesn't like other syntastic cpp checkers enabled at the same time
function! ToggleYcm()
  if g:ycm_register_as_syntastic_checker
    let g:ycm_show_diagnostics_ui = 0
    let g:ycm_register_as_syntastic_checker = 0
    let g:ycm_always_populate_location_list = 0
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
  else
    let g:ycm_show_diagnostics_ui = 1
    let g:ycm_register_as_syntastic_checker = 1
    let g:ycm_always_populate_location_list = 1
    let g:syntastic_always_populate_loc_list = 0
  endif
endfunction

"""""""""""""""""""""""
" From http://vim.wikia.com/wiki/Working_with_CSV_files
" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)


"""""""""""""""""""""""
" Custom
"""""""""""""""""""""""
"""""""""""""""""""""""
" Allow newer vim options (incompatible with older vi options)
set nocompatible
" Auto read file upon changes
set autoread
" when scolling near the top/bottom of the window, keep a few lines visible
" beneath the cursor
set scrolloff=3
" Show the editing mode we are in
set showmode
" Allow wildcards to be used in auto-completion
set wildmenu
" Set a visual bell instead of beeping
set visualbell
set t_vb="|10f"
" Hilight the line the cursor is on
set cursorline
" Hilight the column the cursor is on
set cursorcolumn
" indicate we have a fast terminal so that redraw is better
set ttyfast
" show what line/char we are on
set ruler
" show what line number we are on
" set number
" hilight our search matches
set hlsearch
" show matching parentheses, braces
set showmatch
" do incremental search
set incsearch
" ignore case in searches
set ignorecase
" if upper case chars are used in a search, then do not ignore case
set smartcase
" turn on filetypes plugin so other plugins can tell what type of file we are in
filetype plugin on
" create a custom leader character
let mapleader = ","
" Show the menu at the bottom
set laststatus=2
" Set the menubar text
" set statusline=%F%m%r%h%w\ [ASCII=\%b]\ [HEX=\%04.4B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%f%m%r%h%w\ [ascii=\%03b]\ [hex=\%02B]\ %=%-14.(%l,%c%V%)\ %P\ %LL
" Automatically change the current working directory based on the file being
" edited
set autochdir
" wrap lines around to next line (without inserting a newline) so the whole
" window of text doesn't move over when you are past the window width
set wrap
" Allow backspacing over everything
set bs=indent,eol,start
" Set diff mode to be vertical
set diffopt=filler,vertical
syntax enable
" Enable searching for visually selected text with //
vnoremap // y/<C-R>"<CR>

"""""""""""""""""""""""
" Set up the folding method for python
au BufRead,BufNewFile *.py,*.c,*.cc,*.h set foldmethod=indent
au BufRead,BufNewFile *.py,*.c,*.cc,*.h set foldnestmax=2
au BufRead,BufNewFile *.py,*.c,*.cc,*.h,*.sh set expandtab
au BufRead,BufNewFile *.py,*.c,*.cc,*.h set shiftwidth=2
au BufRead,BufNewFile *.py,*.c,*.cc,*.h set tabstop=2
au BufRead,BufNewFile *.py,*.c,*.cc,*.h,*.sh set autoindent
au BufRead,BufNewFile *.py,*.c,*.cc,*.h,*.sh set smartindent

set background=dark
set bg=dark
"colorscheme solarized
colorscheme molokai

" Set the number of colors so that the syntax hilighting sucks less
set t_Co=256

" Hilight whitespace at the end of lines
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter *.py,*.c,*.cc,*.h match ExtraWhitespace /\s\+$/
au BufEnter *.py,*.c,*.cc,*.h,*.sh match ExtraWhitespace /\t/
au InsertEnter *.py,*.c,*.cc,*.h match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave *.py,*.c,*.cc,*.h match ExtraWhiteSpace /\s\+$/
au InsertLeave *.py,*.c,*.cc,*.h match ExtraWhiteSpace /\t/

" save/restore file location state
" Saves to 'viewdir' (default ~/.vim/view)
au BufWinLeave *.py,*.txt,*.c,*.cc,*.h,*.conf mkview
au BufWinEnter *.py,*.txt,*.c,*.cc,*.h,*.conf silent loadview

" Open ctrlp's buffers
nmap <Leader>b :CtrlPBuffer<cr>
" Open BufExplorer
nmap <Leader>B :BufExplorer<cr>
" Toggle comment on each line
map <Leader>c <plug>NERDCommenterToggle
" close preview window
map <Leader>C :pclose<cr>
" YCM: Go to definition
map <Leader>d :YcmCompleter GoToDefinitionElseDeclaration<cr>
nmap <Leader>H <Plug>HexManager
nmap <Leader>N :NERDTree<cr>
" whitespace intentional
nmap <Leader>m :NERDTreeFromBookmark 
" Open ctrl-p in regular mode
nmap <Leader>p :CtrlP<cr>
" Open ctrl-p in MRU mode
nmap <Leader>P :CtrlPMRU<cr>
" split windows into three vertical splits and resize first two to 82 columns
" (includes 2 columns for syntastic)
nmap <Leader>T <C-w>v<C-w>v:vertical res 82<cr><C-w>l:vertical res 82<cr>
" Close preview window
nmap <Leader>w <C-W>z<cr>
" Re-read vimrc file
nmap <Leader>v :so ~/.vimrc<cr>
" Strip trailing whitespace
nmap <leader><space> :call Strip_trailing()<CR>
" move tab left/right
nmap <leader>h :tabprevious<CR>
nmap <leader>l :tabnext<CR>
" copy the current (single) line, and comment it out then paste
nmap <Leader>y yy<Esc><plug>NERDCommenterToggle<Esc>p
" copy current visual selection, comment it out and paste it
vmap <Leader>y ygv<plug>NERDCommenterToggle<Esc>gv<Esc>p
" Old version
" nmap <Leader>y yy0wi#<Esc>p
nmap <Leader>Y :call ToggleYcm()<CR>
" Execute python on the visual buffer
"vmap <Leader>M <Esc>`>a<CR><Esc>`<i<CR>print <Esc>!!python<CR>kJJ
map <Leader>M :python pyexec()<CR>
nmap <Leader>dt :python printDate()<CR>
" To enable eregex
map <Leader>/ :M/

" imap <C-S> <esc>a<Plug>snipMateNextOrTrigger
imap <C-S> <esc>a TriggerSnippet()<CR>

" Remap clear because we are using it for window navigation
map <C-L> :redraw!

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" let ropevim_local_prefix=",r"
" let ropevim_global_prefix=",R"
map <Leader>r <C-c>r
map <Leader>r <C-c>r

" Have NERDTree close after we select our file
let NERDTreeQuitOnOpen=1
" Lets nerd tree hijack the netrw for file exploration, but it seems borken
" let NERDTreeHijackNetrw=1
let NERDTreeIgnore = ['\.git','\.hg','\.svn','\.DS_Store']
let NERDTreeShowBookmarks = 1
" let NERDTreeWinPos = 'right'
let NERDTreeWinSize = 79

" Syntastic
" let g:syntastic_python_checker_args='--single-file=y --rcfile=/usr/local/google/home/aaronpeterson/.pylintrc '
let g:syntastic_python_checker_args='--single-file=y '
" Don't check the syntax unless I ask it to with :SyntasticCheck, but for python
" check automatically on write.
let g:syntastic_mode_map = {
    \ 'mode': 'passive',
    \ 'active_filetypes': ['python', 'cpp'] }
" Comment this out if enabling ycm as a syntastic checker
" Disable ycm by default, but <leader>Y is mapped to toggling this on/off
let g:ycm_register_as_syntastic_checker = 0
let g:syntastic_cpp_checkers = ['cpplint', 'gcc']
let g:ycm_autoclose_preview_window_after_insertion = 1
" Fix letting syntastic set Errors, need to test that it doesn't conflict with
" YCM
let g:syntastic_always_populate_loc_list = 1
let g:ycm_always_populate_location_list = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_error_symbol = 'Y>'
let g:ycm_warning_symbol = 'y>'
" ultisnips
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:ultisnips_python_style = "google"


" Allows you to yank visually selected text into the paste buffer with "*y
" '*' becomes a register for the local paste buffer
set clipboard=unnamed

" BufferExplorer configuration
let g:bufExplorerShowDirectories=0

" Set to black background after 80 chars
highlight ColorColumn ctermbg=232
let &colorcolumn=join(range(81,999),",")
" Set row line slightly brighter than the default
highlight ColorLine ctermbg=235

" Mouse options
set mouse=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Python functions
" pyexec is to execute python over the current visual selection (good for math
" in vim)
python << EOF
import sys
import os
home = os.environ['HOME']
sys.path.append(os.path.join(home, ".vim/bundle/ropevim"))
sys.path.append(os.path.join(home, ".vim/bundle/ropemode"))

def insert(fragment):
  import vim
  line = vim.current.line
  col = vim.current.window.cursor[1]
  vim.current.line = line[:col] + fragment + line[col:]

def replace(fragment):
  import vim
  buf = vim.current.buffer
  # TODO: work on multi-line
  start = buf.mark("<")[1]
  end = buf.mark(">")[1] + 1
  line = vim.current.line
  vim.current.line = line[:start] + fragment + line[end:]

def printDate():
  import datetime
  insert(datetime.datetime.today().strftime('%Y%m%d') + " ")

def pyexec():
  buf = vim.current.buffer
  start = buf.mark("<")[1]
  end = buf.mark(">")[1] + 1
  line = vim.current.line[start:end]
  tmp = ""
  expr = "tmp = %s" % line
  exec(expr)
  replace(str(tmp))

EOF
