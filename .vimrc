set nocompatible              " be iMproved, required
set t_Co=256
filetype off                  " required

set rtp+=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
call dein#begin(expand('~/.config/nvim/bundle'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-go', {'build': 'make'})
call dein#add('saltstack/salt-vim')
call dein#add('godlygeek/tabular')
call dein#add('gabrielelana/vim-markdown')
"call dein#add('altercation/vim-colors-solarized')
call dein#add('matthewtodd/vim-twilight')
call dein#add('scrooloose/syntastic')
call dein#add('easymotion/vim-easymotion')
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
"call dein#add('derekwyatt/vim-scala')
call dein#add('fatih/vim-go')
"call dein#add('Shougo/context_filetype.vim')
call dein#add('Shougo/neopairs.vim')
call dein#add('Shougo/echodoc.vim')
"call dein#add('Shougo/neoinclude.vim')
call dein#add('vim-airline/vim-airline')
call dein#add('majutsushi/tagbar')
call dein#add('bling/vim-bufferline')

call dein#end()

filetype plugin on

syntax on
set number
set rnu
set list
set lcs=tab:\|\ ,trail:·,eol:↲
"set statusline+=%{fugitive#statusline()}


set tabstop=2
set softtabstop=2
set shiftwidth=2
set noexpandtab
set noshowmode

autocmd FileType yaml set expandtab
autocmd FileType go set noexpandtab

set clipboard+=unnamedplus
set completeopt-=preview

colorscheme twilight
autocmd VimEnter,Colorscheme * :hi Normal ctermbg=none

map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

let g:EasyMotion_smartcase = 1
let g:syntastic_go_checkers = ['go']
let g:go_fmt_options = '-s'
let g:go_metalinter_enabled = ['gofmt', 'gotype', 'goimports', 'dupl', 'golint', 'structcheck', 'aligncheck', 'vet', 'errcheck', 'ineffassign', 'vetshadow', 'varcheck', 'deadcode', 'interfacer', 'goconst', 'gosimple', 'staticcheck']
let g:echodoc_enable_at_startup = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:bufferline_echo = 0
let g:airline#extensions#whitespace#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_section_y = airline#section#create([''])
let g:airline_section_z = airline#section#create(['%l/%L'])
let g:fugitive_git_executable = "env GIT_SSH_COMMAND='ssh -o ControlPersist=no' git"

"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1
"let g:indent_guides_auto_colors = 0
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=gray   ctermbg=DimGray
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=black ctermbg=black
"
