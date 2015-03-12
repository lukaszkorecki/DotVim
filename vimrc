call pathogen#runtime_append_all_bundles()
"" Pathogen -----------------------------------------------------------------
" call pathogen#helptags()

runtime macros/matchit.vim

"" Global settings ----------------------------------------------------------
set fileencoding=utf8
set nocompatible
filetype plugin on
filetype indent on
filetype on
syntax on
set showbreak=$
set guioptions=eg
set title

" visual clues for commands and navigation
set showcmd
set ruler
set scrolloff=3
set nofoldenable
set lazyredraw

" Wildmenu bro!
set wildmenu
set wildmode=list:longest,full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" search --------------------------------------------------------------------
set incsearch ignorecase smartcase hlsearch
:nnoremap <space> :nohlsearch<cr>

" No backups ----------------------------------------------------------------
" Vim crashes so rarely I don't feel like I need these
set nobackup nowritebackup noswapfile

" status line --------------------------------------------------------------
set statusline=
" file name
set statusline+=%f\ %2*%m\ %1*%h
" generic warning message
set statusline+=%#warningmsg#
" Syntastic status
set statusline+=%{SyntasticStatuslineFlag()}
" FuGITive status
set statusline+=%{fugitive#statusline()}
" span
set statusline+=%*

" [ encoding filetype]
set statusline+=%r%=[%{&encoding}\ %{strlen(&ft)?&ft:'none'}]

" current column line and total number of lines
set statusline+=\ %12.(%c:%l/%L%)

" always show status line
set laststatus=2

" backspace mode -----------------------------------------------------------
set bs=2

" lines and margins --------------------------------------------------------
" highlight current line and add line numbers
set cursorline number

" nice colors for error messages
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" right margin settings
if version > 702
  set colorcolumn=78
endif

" general text layout stuff ------------------------------------------------
" set line length for all files at 78
autocmd FileType text setlocal textwidth=78

" use spelling in email and git commit messages
autocmd FileType mail,gitcommit set spell
set spellsuggest=5


" colors -------------------------------------------------------------------
let &t_Co=256
set background=dark
if &term =~ '256color'
  " Disable Background Color Erase (BCE) so that color schemes
  " work properly when Vim is used inside tmux and GNU screen.
  " See also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

colorscheme default

" indent --------------------------------------------------------------------
set softtabstop=2 shiftwidth=2 tabstop=2 expandtab

" Key mappings -------------------------------------------------------------

" make the command mode less annoying
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-p> <Up>
cnoremap <c-n> <Down>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-d> <Del>
" use %/ as current directory
cmap %/ %:p:h/

" open current file's location
nnoremap <Leader>d :e <C-R>=expand('%:p:h') . '/'<CR>

nnoremap <leader>c :copen<cr>
nnoremap <leader>l :lopen<cr>
nnoremap <leader>e :Errors<cr>
nnoremap <leader>C :cclose<cr>
" Better split management, kept in sync with tmux' mappings
" (<prefix>| and <prefix>-)

"split horizontally and switch to new split
noremap <leader>- :sp<CR><C-w>j
"split vertically and switch to new split
noremap <leader>\| :vsp<CR><C-w>l

" Borrowed from vimcasts, super useful----------------------------------------
" Bubble single lines
nmap <C-k> ddkP
nmap <C-j> ddp

" Bubble multiple lines
vmap <C-k> xkP`[V`]
vmap <C-j> xp`[V`]

" make tab key more better
noremap <tab> v>
noremap <s-tab> v<
vnoremap <tab> >gv
vnoremap <s-tab> <gv

" Own commands ---------------------------------------------------------------
cnoreabbrev E e
cnoreabbrev W w

" NETRW setttings ------------------------------------------------------------
let g:netrw_banner=0

" Programming language support and improvements ------------------------------

" YAML -----------------------------------------------------------------------

au BufNewFile,BufRead Procfile set filetype=yaml

" Ruby -----------------------------------------------------------------------
" non ruby files which are ruby
au BufNewFile,BufRead Puppetfile,Capfile,Gemfile,Guardfile,Rakefile,*.rake set filetype=ruby

" reject! and responds_to? are methods in ruby
autocmd FileType ruby setlocal iskeyword+=!,?,@

" Abbreviations aka snippets
autocmd Filetype ruby iabbr deb_ require 'pry'; binding.pry

" Ruby
autocmd Filetype ruby iabbr init- def initialize<CR>end<ESC>?initialize<ESC>$a
autocmd Filetype ruby iabbr cls- class<CR>end<ESC>?class<ESC>$a
autocmd Filetype ruby iabbr mod- module<CR>end<ESC>?module<ESC>$a
autocmd Filetype ruby iabbr d= def<CR>end<ESC>?def<ESC>$a
autocmd Filetype ruby iabbr d_ do<CR>end<ESC>O
autocmd Filetype ruby iabbr d- do \|\|<CR>end<ESC>k$i
autocmd Filetype ruby iabbr {- { \|A\| }<ESC>FA"_xi
autocmd Filetype ruby iabbr #- #{}<ESC>'_ci{
autocmd Filetype ruby iabbr rq- require ''<ESC>i

" ERB
autocmd Filetype eruby iabbr rt+ <% woo %><ESC>Fw<ESC>"_ciw
autocmd Filetype eruby iabbr rt- <% woo%><ESC>Fw<ESC>"_ciw
autocmd Filetype eruby iabbr rt= <%= woo%><ESC>Fw<ESC>"_ciw
autocmd Filetype eruby iabbr rtc <%# woo%><ESC>Fw<ESC>"_ciw

" Rspec yea
autocmd Filetype ruby iabbr dsc- describe  do<CR>end<ESC>?describe<ESC>wi
autocmd Filetype ruby iabbr it- it '' do<CR>end<ESC>?''<ESC>a
autocmd Filetype ruby iabbr cnt- context '' do<CR>end<ESC>?''<ESC>a
autocmd Filetype ruby iabbr sub- subject '' do<CR>end<ESC>?''<ESC>a
autocmd Filetype ruby iabbr lt- let : { }<ESC>?:<ESC>a

" minitest
autocmd Filetype ruby iabbr test- test '' do<CR>end<ESC>?''<ESC>a

function! RspecInPane()
  exec "Gcd"
  let f = expand("%")
  let cmd = "tmux split-window 'bundle exec rspec ". shellescape(f) . " || bash '"
  silent exec "! ".cmd
endf


function! TestUnitFile()
  exec "Gcd"
  silent exec "! tmux split-window 'tu ".expand('%'). " || bash'"
endf

au Filetype ruby map <leader>r :silent call RspecInPane()<cr>
au Filetype ruby map <leader>u :silent call TestUnitFile()<cr>

let g:syntastic_ruby_checkers = ['mri', 'rubocop']

function! RubocopFix()
  w!
  set autoread
  silent exec "! rubocop -a ".expand('%')
  redraw!
  set noautoread
  e!
  w
endf

au Filetype ruby map <leader>f :silent call RubocopFix()<cr>

" make rspec stuff part of ruby syntax
autocmd BufNewFile,BufRead *_spec.rb syn keyword ruby describe
      \ context
      \ it
      \ specify
      \ it_should_behave_like
      \ before
      \ after
      \ setup
      \ subject
      \ its
      \ shared_examples_for
      \ shared_context
      \ let


" Cowsay --------------------------------------------------------------------
au BufNewFile,BufRead  *.cow set ft=sh

" Puppet --------------------------------------------------------------------
au BufNewFile,BufRead  *.pp set ft=puppet

" Javascript ----------------------------------------------------------------
" json & javascript
au BufNewFile,BufRead  *.json set ft=json
let g:syntastic_javascript_jshint_conf = expand("~/.jshint.json")

autocmd Filetype javascript iabbr f- function(){}<ESC>F{a
autocmd Filetype javascript iabbr fn- function(){}<ESC>F(i
autocmd Filetype javascript iabbr cl- console.log('');<ESC>F'i
autocmd Filetype javascript iabbr ci- console.info('');<ESC>F'i
autocmd Filetype javascript iabbr deb_ debugger;

" coffeescript
au BufNewFile,BufRead  *.coffee set ft=coffee

" markdown
au BufNewFile,BufRead  *.md,*.mkd,*.markdown set filetype=markdown

" clojure
au BufNewFile,BufRead  *.clj set filetype=clojure

" python and go is weird
au BufNewFile,BufRead *.py,*.go set tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.py,*.go set list listchars=tab:\|\ ,eol:~

" go specific
au BufNewFile,BufRead *.go set ft=go
au BufNewFile,BufRead *.go set noexpandtab

" SCSS
autocmd FileType scss setlocal iskeyword+=-,$,@

" Scheme is a LISP, clojure as well
au BufNewFile,BufRead *.scm,*.clj set lisp

" Plugins settings ----------------------------------------------------------
" git-browse mappings
nnoremap <leader>B :call gitsurf#File()<CR>
vnoremap <leader>B :call gitsurf#FileRange()<CR>

" ctrl-p
let g:ctrlp_extensions = ['tag' ]
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

" syntastic
let g:syntastic_auto_loc_lis=1

" tagbar
nnoremap <leader>T :TagbarToggle<CR>

" fugitive
noremap <leader>g :Ggrep <cword><CR>

" tags
set tags=./tags,tags,TAGS,ctags,./js.tags,./rb.tags,../project.tags

" Abbreviations  ------------------------------------------------------------
iabbr me- Łukasz

" Functions and hooks -------------------------------------------------------

fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e

  call cursor(l, c)
endfun
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function! ConvertHash()
  let @z="xf Pf=df "
  :normal @z
endf
nmap <leader>ch :call ConvertHash()<cr>

function! FixNetrw()
  set modifiable
  set number
  w!
endf
nmap <leader>w :call FixNetrw()<cr>

function! SudoWrite()
  w !sudo tee % >/dev/null
endf


function! GenTags()
  exec "Gcd"
  call system("ctags -R . ")
  echom "Tags generated!"
endf
map <leader>t :call GenTags()<cr>

nnoremap <leader>F :redraw!<cr>


" selecta stuff
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <C-p> :call SelectaCommand("git ls-files", "", ":e")<cr>
