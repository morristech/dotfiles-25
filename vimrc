" ~/.vimrc

" Preamble ---------------------------------------------------------------- {{{

" Jesse Atkinson | jesse@jsatk.us | @jsatk
" https://github.com/jsatk/dotfiles/blob/master/vimrc

" To see what any of the settings below do press `K` while your cursor is on
" the setting in question and it will open the manual in a split.

" }}}
" Vim Plugins ------------------------------------------------------------- {{{

" This check is done in vim-sensible, however as of this writing that check
" doesn't apply to Vim 8.  Until vim-dispatch works nicely with Fish shell or
" until vim-sensible's Fish shell check applies to Vim 8 and above I need to
" manually force my shell here.  Also setting it to simply `sh` instead of
" `/bin/bash` because vim-dispatch apparently has trouble inferring the PID of
" the task when `shell` is set to `/bin/bash`.  Computers are hard.
"
" See here:
" https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim#L66-L68
if &shell =~# 'fish$'
  set shell=sh
endif

packadd minpac " https://github.com/k-takata/minpac

call minpac#init()

" minpac must have {'type': 'opt'} so that it can be loaded with `packadd`.
call minpac#add('k-takata/minpac', {'type': 'opt'})

" Add other plugins here.
call minpac#add('dag/vim-fish')
call minpac#add('derekwyatt/vim-sbt')
call minpac#add('derekwyatt/vim-scala')
call minpac#add('ervandew/supertab')
call minpac#add('fatih/vim-go')
call minpac#add('janko-m/vim-test')
call minpac#add('jsatk/vim-colorschemes')
call minpac#add('junegunn/fzf.vim')
call minpac#add('junegunn/goyo.vim')
call minpac#add('junegunn/gv.vim')
call minpac#add('junegunn/vim-easy-align')
call minpac#add('Konfekt/FastFold')
call minpac#add('mxw/vim-jsx')
call minpac#add('nicholaides/words-to-avoid.vim')
call minpac#add('pangloss/vim-javascript')
call minpac#add('rizzatti/dash.vim')
call minpac#add('rust-lang/rust.vim')
call minpac#add('sgur/vim-editorconfig')
call minpac#add('tpope/vim-abolish')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-db')
call minpac#add('tpope/vim-dispatch')
call minpac#add('tpope/vim-endwise')
call minpac#add('tpope/vim-fugitive')
call minpac#add('tpope/vim-obsession')
call minpac#add('tpope/vim-projectionist')
call minpac#add('tpope/vim-repeat')
call minpac#add('tpope/vim-rhubarb')
call minpac#add('tpope/vim-scriptease')
call minpac#add('tpope/vim-sensible')
call minpac#add('tpope/vim-sleuth')
call minpac#add('tpope/vim-surround')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vinegar')
call minpac#add('vim-airline/vim-airline')
call minpac#add('vim-airline/vim-airline-themes')
call minpac#add('vim-scripts/LargeFile')
call minpac#add('w0rp/ale')
packloadall

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" }}}
" Basic Options ----------------------------------------------------------- {{{

set wildmode=list:longest
set ttyfast
set t_Co=256
set expandtab
set shiftround
set shiftwidth=2
set softtabstop=2
set cursorline
set list " Show select “invisible” characters
set lazyredraw
set showbreak=↪
set hlsearch
set splitbelow
set splitright
set autoread
set autowrite
set synmaxcol=800
set ignorecase " Ignore the case, unless...
set smartcase  " ...there's caps in it.
set mousehide
set laststatus=2
set nostartofline
set showmode
set showcmd
set title
set linebreak
set breakindent
set textwidth=0
set wrapmargin=0
set scrolloff=3
set showmatch
set matchtime=3
set gdefault
set timeoutlen=500
set nf=octal,hex,alpha " Increment alpha strings with vim
set hidden

if has('mouse')
  set mouse=a
endif

" }}}
" Spelling ---------------------------------------------------------------- {{{

" Stolen from Steve Losh
"
" There are three dictionaries I use for spellchecking:
"
"   /usr/share/dict/words
"   Basic stuff.
"
"   ~/.vim/custom-dictionary.utf-8.add
"   Custom words (like my name).  This is in my (version-controlled) dotfiles.
"
"   ~/.vim-local-dictionary.utf-8.add
"   More custom words.  This is *not* version controlled, so I can stick
"   work stuff in here without leaking internal names and shit.
"
" I also remap zG to add to the local dict (vanilla zG is useless anyway).
set dictionary=/usr/share/dict/words
set spellfile=~/.vim/custom-dictionary.utf-8.add,~/.vim-local-dictionary.utf-8.add
nnoremap zG 2zg

" }}}
" Look & Feel ------------------------------------------------------------- {{{

set background=dark
colorscheme lucius

" Check out my blog post about this here:
" https://jsatk.us/vim-tmux-italics-and-insanity-9a96b69eeca6#.q0ygz6too
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
highlight Comment cterm=italic

set guifont=OperatorMonoForPowerline-Book:h18

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}
" Convenience Mappings ---------------------------------------------------- {{{

let mapleader = ","

noremap q: :q " Do not show stupid q: window
noremap Q <Nop> " I don't know how to use ex mode and it scares me.
nnoremap S i<cr><esc><right> " Split line (sister to [J]oin lines)
nnoremap <leader><leader> <c-^> " switch to last file
nnoremap <leader>r :redraw!<cr> " redraw the buffer
nnoremap <CR> :nohlsearch<cr> " Clear the search buffer when hitting return
" Don't jump-to-next when I use * to search for what's under cursor.
nnoremap * *<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Clean trailing whitespace.
nnoremap <leader>w mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" My garbage brain can't ever remember digraph codes
inoremap <c-k><c-k> <esc>:help digraph-table<cr>

" Only show cursorline in the current window and in normal mode.
augroup cline
  autocmd!

  autocmd WinLeave,InsertEnter * set nocursorline
  autocmd WinEnter,InsertLeave * set cursorline
augroup END

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Toggle quickfix
function! QuickFixIsOpen()
  let l:result = filter(getwininfo(), 'v:val.quickfix && !v:val.loclist')
  return !empty(l:result)
endfunction
nnoremap yoq :<C-R>=QuickFixIsOpen() ? "cclose" : "copen"<CR><CR>

" }}}
" Quick Editing ----------------------------------------------------------- {{{

nnoremap <leader>ed :vsplit ~/.vim/custom-dictionary.utf-8.add<cr>
nnoremap <leader>ef :vsplit ~/.config/fish/config.fish<cr>
nnoremap <leader>eg :vsplit ~/.gitconfig<cr>
nnoremap <leader>em :vsplit ~/.muttrc<cr>
nnoremap <leader>et :vsplit ~/.tmux.conf<cr>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" }}}
" Folding ----------------------------------------------------------------- {{{

set foldenable
set foldlevelstart=0

nnoremap <Space> za
vnoremap <Space> za
nnoremap zO zczO

" "Focus" the current line.  Basically:
"
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a bit (25 lines) down from the top of the screen.
" 4. Pulse the cursor line.  My eyes are bad.
"
" This mapping wipes out the z mark, which I never use.
function! FocusLine()
    let oldscrolloff = &scrolloff
    set scrolloff=0
    execute "keepjumps normal! mzzMzvzt25\<c-y>`z:Pulse\<cr>"
    let &scrolloff = oldscrolloff
endfunction
nnoremap <leader>z :call FocusLine()<cr>

" This function defines what folded text looks like.
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Tags -------------------------------------------------------------------- {{{

" Stolen from:
" https://github.com/mcantor/no_plugins/blob/master/no_plugins.vim#L86

" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
" Default ctags that comes with macOS is hot garbage.  `brew install ctags`
" There's probably a sexy regular expression to do what I'm doing with all the
" multiple exclude statements, but I don't really care.  I'd rather have this be
" verbose and stupidly readable and editable.
command! MakeTags !ctags --recurse
  \ --exclude=".build"
  \ --exclude=".bundle"
  \ --exclude=".git"
  \ --exclude=".tmp"
  \ --exclude="bower_components"
  \ --exclude="coverage"
  \ --exclude="dist"
  \ --exclude="docs"
  \ --exclude="genfiles"
  \ --exclude="log"
  \ --exclude="node_modules"
  \ --exclude="project"
  \ --exclude="target"
  \ --exclude="third_party"
  \ --exclude="vendor"
  \ .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags

" }}}
" Trailing Whitespace ----------------------------------------------------- {{{

" Only shown when not in insert mode so I don't go insane.
augroup trailing
  autocmd!

  autocmd InsertEnter * :set listchars-=trail:⌴
  autocmd InsertLeave * :set listchars+=trail:⌴
augroup END

" }}}
" Line Return ------------------------------------------------------------- {{{

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
  autocmd!

  autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     execute 'normal! g`"zvzz' |
            \ endif
augroup END

" }}}
" Backups ----------------------------------------------------------------- {{{

set undofile                      " Maintain undo history between sessions
set backup                        " enable backups
set noswapfile                    " it's 2018, Vim.
" The extra slash on the end saves files under the name of their full path
" with the / character replaced with a %.
set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
  call mkdir(expand(&undodir), "p")
endif

if !isdirectory(expand(&backupdir))
  call mkdir(expand(&backupdir), "p")
endif

if !isdirectory(expand(&directory))
  call mkdir(expand(&directory), "p")
endif

" }}}
" Filetype Configurations ------------------------------------------------- {{{

" bash {{{

augroup ft_sh
  autocmd!

  autocmd FileType sh setlocal foldmethod=marker
  autocmd Filetype sh setlocal foldmarker={,}
augroup END

" }}}
" conf {{{

augroup ft_conf
  autocmd!

  au BufNewFile,BufRead *.conf set filetype=conf
  autocmd FileType conf setlocal foldmethod=marker
augroup END

" }}}
" crontab {{{

augroup ft_crontab
  autocmd!

  autocmd filetype crontab setlocal nobackup nowritebackup
augroup END

" }}}
" css {{{

augroup ft_css
  autocmd!

  autocmd Filetype css setlocal iskeyword+=-
augroup END

" }}}
" fish {{{

augroup ft_fish
  autocmd!

  autocmd BufNewFile,BufRead *.fish setlocal filetype=fish
  " The line below sets up :make to use fish for syntax checking.
  autocmd FileType fish compiler fish

" }}}
" gitcommit {{{

" Add hanging indent auto-formatting for git commit messages.  Unfortunately
" the gitcommit settings in Vim-Fugitive don't handle hanging indents for
" bulleted lists.
augroup ft_gitcommit
  autocmd!

  autocmd FileType gitcommit setlocal comments+=fb:-,fb:*
  autocmd FileType gitcommit setlocal formatoptions+=q
  autocmd FileType gitcommit setlocal formatoptions+=2
  autocmd FileType gitcommit setlocal formatoptions+=n
  autocmd FileType gitcommit setlocal foldlevelstart=-1
augroup END

" }}}
" mail {{{

augroup ft_mail
  autocmd!

  autocmd FileType mail setlocal textwidth=0
augroup END

" }}}
" markdown {{{

augroup ft_markdown
  autocmd!

  autocmd BufNewFile,BufRead *.m*down,*.md setlocal spell filetype=markdown
  autocmd FileType markdown setlocal textwidth=0
  autocmd FileType markdown setlocal foldlevelstart=-1
  autocmd BufRead,BufNewFile .plan setlocal filetype=markdown

  set formatoptions+=t
augroup END

" }}}
" python {{{

augroup ft_python
  autocmd!

  " Ignore compiled python
  set wildignore=*.pyc
  set foldmethod=indent
  let g:netrw_list_hide= '.*\.pyc$'
augroup END

" }}}
" ruby {{{

augroup ft_ruby
  autocmd!

  autocmd FileType ruby setlocal foldmethod=syntax
  autocmd BufRead,BufNewFile Capfile setlocal filetype=ruby
augroup END

" }}}
" scala {{{

augroup ft_scala
  autocmd!

  autocmd Filetype scala setlocal foldmethod=syntax
augroup END

" }}}
" vim {{{

augroup ft_vim
  autocmd!

  " Make vim resize on host window resize.  Great for increaseing/decreasing
  " font or when you disconnect from your external monitor.
  autocmd VimResized * wincmd =
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType help setlocal textwidth=80
  autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}

" }}}
" Vim Plugin Configurations ----------------------------------------------- {{{

" Airline {{{

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''

" }}}
" Asynchronous Lint Engine (ALE) {{{

highlight clear ALEErrorSign " otherwise uses error bg color (typically red)
highlight clear ALEWarningSign " otherwise uses error bg color (typically red)

let g:ale_statusline_format = ['X %d', '? %d', '']

" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says: "%severity% %...code...% – %s'

" }}}
" Dash {{{

nmap <silent> <leader>d <Plug>DashSearch

" }}}
" Dispatch {{{

nnoremap <F9> :Dispatch<CR>

" }}}
" EasyAlign {{{

" Start interactive EasyAlign in visual mode (e.g. vipga).
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" Intentionally not using `nnoremap`.
" Note: Using |:noremap| will not work with <Plug> mappings.
nmap ga <Plug>(EasyAlign)

" }}}
" Fugitive {{{

" Get a direct link to the current line (with specific commit included!) and
" copy it to the system clipboard
command! Glink silent! .Gbrowse! -

" }}}
" FZF {{{

" Allows us to use FZF in Vim.
set rtp+=/usr/local/opt/fzf
nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <C-p><C-f> :<C-u>Buffers<CR>
" Sets the search command for FZF.  `rg` follows `.gitignore`s rules if a
" `.gitignore` is found.
let $FZF_DEFAULT_COMMAND = 'rg --files'

" }}}
" Goyo {{{

noremap <leader>g :Goyo<CR>

" }}}
" Javascript {{{

let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1

" }}}

" }}}
" Mini-plugins ------------------------------------------------------------ {{{

" Pulse Line {{{

" TODO: Replace this with a proper plugin when you can.
" Stolen from Steve Losh.
function! s:Pulse()
    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    let steps = 8
    let width = 1
    let start = width
    let end = steps * width
    let color = 233

    for i in range(start, end, width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor
    for i in range(end, start, -1 * width)
        execute "hi CursorLine ctermbg=" . (color + i)
        redraw
        sleep 6m
    endfor

    execute 'hi ' . old_hi
endfunction
command! -nargs=0 Pulse call s:Pulse()

" }}}

" }}}
" Arc/Phabricator --------------------------------------------------------- {{{

" Phabricator is the worst, but I have to deal with it so here I am.  This is
" a tiny wrapper I made so that I can simply run arc commands from inside vim
" without having to type `:Dispatch` first.  Maybe someday I'll expand on this
" and make it a proper plugin.
"
" Examples:
" :Arc diff --verbatim --browse
" :Arc upload ~/Desktop/screenshot.png
" :Arc amend
" :Arc land --onto master
function! s:Arc(cmd)
  execute "Dispatch arc " . a:cmd
endfunction
command! -nargs=1 Arc call s:Arc(<f-args>)

" }}}

set secure " Disables unsafe commands in project-specific .vimrc files.
set exrc " Allows for project-specific vimrc files.
