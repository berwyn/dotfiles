runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"""""""""""
"=> GENERAL
"""""""""""

filetype plugin on
filetype indent on

set autoread

""""""
"=> UI
""""""

set number
set numberwidth=5
highlight LineNr ctermfg=white ctermbg=darkgrey
highlight CursorLineNr ctermfg=0 ctermbg=4

set ruler
set cursorline
set showcmd
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search and make it work like
" modern browsers
set hlsearch
set incsearch

" Don't redraw while executing macros
set lazyredraw

" Highlight matching brackets
set showmatch

" Add left padding
set foldcolumn=1

if has('mouse')
	set mouse=a
endif

" Force 256 colors
set term=xterm
set t_Co=256

if has('win32') && !has('gui_running') && !empty($CONEMUBUILD)
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
endif

""""""""""""""""
"=> COLORS/FONTS
""""""""""""""""
syntax enable

try
    color Tomorrow-Night-Eighties
catch
endtry

set background=dark
set encoding=utf8
set ffs=unix,dos,mac

""""""""
"=> TABS
""""""""

set expandtab
set smarttab

" Tab width
set shiftwidth=4
set tabstop=4

set ai "auto indent
set si "smart indent

"""""""""""""""
"=> STATUS LINE
"""""""""""""""

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

"""""""""""
"=> AIRLINE
"""""""""""

function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode', ' ', 'branch'])
endfunction
autocmd VimEnter * call AirlineInit()

syntax on

set hidden
if has('win32') || has('win64')
    let g:racer_cmd=$HOME . ".cargo\\bin\\racer"
    let $RUST_SRC_PATH=$HOME . "dev\\rust\\src\\"
elseif has('osx')
    let g:racer_cmd = "/Users/berwyn/.cargo/bin/racer"
    let $RUST_SRC_PATH = "/Users/berwyn/dev/rust/src/"
endif

" Color test: Save this file, then enter ':so %'
" Then enter one of following commands:
"   :VimColorTest    "(for console/terminal Vim)
"   :GvimColorTest   "(for GUI gvim)
function! VimColorTest(outfile, fgend, bgend)
  let result = []
  for fg in range(a:fgend)
    for bg in range(a:bgend)
      let kw = printf('%-7s', printf('c_%d_%d', fg, bg))
      let h = printf('hi %s ctermfg=%d ctermbg=%d', kw, fg, bg)
      let s = printf('syn keyword %s %s', kw, kw)
      call add(result, printf('%-32s | %s', h, s))
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
" Increase numbers in next line to see more colors.
command! VimColorTest call VimColorTest('vim-color-test.tmp', 12, 16)

function! GvimColorTest(outfile)
  let result = []
  for red in range(0, 255, 16)
    for green in range(0, 255, 16)
      for blue in range(0, 255, 16)
        let kw = printf('%-13s', printf('c_%d_%d_%d', red, green, blue))
        let fg = printf('#%02x%02x%02x', red, green, blue)
        let bg = '#fafafa'
        let h = printf('hi %s guifg=%s guibg=%s', kw, fg, bg)
        let s = printf('syn keyword %s %s', kw, kw)
        call add(result, printf('%s | %s', h, s))
      endfor
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
command! GvimColorTest call GvimColorTest('gvim-color-test.tmp')
