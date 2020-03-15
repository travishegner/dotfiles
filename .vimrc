if !exists('g:vscode')
	set nocompatible              " be iMproved, required
	set nofoldenable
	filetype off                  " required

	set termguicolors

	set rtp+=~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim
	if dein#load_state(expand('~/.config/nvim/bundle'))
		call dein#begin(expand('~/.config/nvim/bundle'))

		"plugin manager
		call dein#add(expand('~/.config/nvim/bundle/repos/github.com/Shougo/dein.vim'))

		"autocomplete
		"call dein#add('Shougo/deoplete.nvim')
		"call dein#add('Shougo/neoinclude.vim')
		"call dein#add('Shougo/neosnippet')
		"call dein#add('Shougo/neosnippet-snippets')
		"call dein#add('Shougo/echodoc.vim')
		"call dein#add('zchee/deoplete-go', {'build': 'make'})
	"
		"syntax
		call dein#add('scrooloose/syntastic')
		call dein#add('fatih/vim-go')
		"call dein#add('Shougo/neopairs.vim')
		call dein#add('fatih/vim-hclfmt')

		"colors/visuals
		call dein#add('luochen1990/rainbow')
		call dein#add('saltstack/salt-vim')
		call dein#add('jaywilliams/vim-vwilight')
		call dein#add('gabrielelana/vim-markdown')
		call dein#add('airblade/vim-gitgutter')
		call dein#add('b4b4r07/vim-hcl')

		"nerdtree
		call dein#add('Xuyuanp/nerdtree-git-plugin')
		call dein#add('scrooloose/nerdtree')

		"git
		call dein#add('tpope/vim-fugitive')

	"	"nav
		call dein#add('easymotion/vim-easymotion')
		call dein#add('vim-airline/vim-airline')
		call dein#add('majutsushi/tagbar')
		call dein#add('bling/vim-bufferline')


		"disabled
		"call dein#add('godlygeek/tabular')
		"call dein#add('altercation/vim-colors-solarized')
		"call dein#add('Shougo/context_filetype.vim')

		call dein#end()
		call dein#save_state()
	endif

	filetype plugin on

	syntax on
	set hidden
	set number
	set rnu
	set list
	set lcs=tab:\|\ ,trail:·,eol:⏎,space:·
	"set statusline+=%{fugitive#statusline()}

	set mouse=a
	set tabstop=2
	set softtabstop=2
	set shiftwidth=2
	set noexpandtab
	set noshowmode

	autocmd FileType yaml set expandtab
	autocmd FileType go set noexpandtab

	set clipboard+=unnamedplus
	set completeopt-=preview

	colorscheme vwilight
	autocmd VimEnter,Colorscheme * :hi Normal ctermbg=none guibg=none
	autocmd VimEnter,Colorscheme * :hi NonText ctermbg=none guibg=none

	map  / <Plug>(easymotion-sn)
	omap / <Plug>(easymotion-tn)
	map  n <Plug>(easymotion-next)
	map  N <Plug>(easymotion-prev)

	"imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<CR>"

	command Bq execute ":bp | bd #"

	let g:EasyMotion_smartcase = 1
	let g:syntastic_php_checkers = ['php']
	let g:syntastic_go_checkers = ['go']
	let g:go_fmt_options = ''
	let g:echodoc_enable_at_startup = 1
	let g:deoplete#enable_at_startup = 1
	"let g:neosnippet#enable_completed_snippet = 1
	let g:deoplete#max_abbr_width = 0
	let g:deoplete#max_menu_width = 0
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#bufferline#enabled = 0
	let g:bufferline_echo = 0
	let g:airline#extensions#whitespace#enabled = 1
	let g:airline_powerline_fonts = 1
	let g:airline_section_y = airline#section#create([''])
	let g:airline_section_z = airline#section#create(['%l/%L %c'])
	let g:fugitive_git_executable = "env GIT_SSH_COMMAND='ssh -o ControlPersist=no' git"
	"let g:powerline_pycmd="py3"

	let g:deoplete#omni#input_patterns = {}
	let g:deoplete#omni#input_patterns.scala = ['[^. *\t]\.\w*', '[:\[,] ?\w*', '^import .*']

	let g:rainbow_active = 1
endif
