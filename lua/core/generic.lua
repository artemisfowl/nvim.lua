-- generic settings (to be applied across all the files opened)
-- [global settings]
--vim.o.statusline = "%=[%l,%c%V] [%p%%]"
vim.o.ruler = true
vim.o.laststatus = 2
vim.o.autochdir = false

-- [window local settings]
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.cursorline = true

-- [buffer local settings]
vim.bo.swapfile = false

-- [ctags]
vim.opt.tags = 'tags'

-- [clipboard related settings]
-- fixme: try to keep as less of this as possible
vim.cmd[[ set clipboard=unnamed ]]
vim.cmd[[ map! <silent> <F4> <ESC>:NvimTreeToggle<CR> ]]
vim.cmd[[ map <silent> <F4> :NvimTreeToggle<CR> ]]
vim.cmd[[
	augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=1000})
	augroup END
]]

-- [filetype plugin loading]
vim.cmd[[ filetype plugin indent on ]]

-- [Syntax and grep related functions]
vim.cmd[[
	syntax enable
	set grepprg=grep\ -nH\ $*
]]

-- [remember selection post indentation]
vim.cmd[[
	xnoremap < <gv
	xnoremap > >gv
]]

-- [fold related settings]
vim.cmd[[
	set foldmethod=indent
	set foldnestmax=10
	set nofoldenable
	set foldlevel=1
	set tabpagemax=1000
]]

-- [tab completion of commands]
vim.cmd[[
	set wildmenu
	set wildmode=list:longest,full
]]

-- [enable mouse support in terminal]
vim.cmd [[
	set mouse=a
]]

-- [a few other generic settings]
vim.cmd[[
	" Got backspace?
	set backspace=2

	" Ignoring case is a fun trick
	set ignorecase

	" And so is Artificial Intellegence!
	set smartcase

	" Enabling Autosave feature with jj - should be rarely used
	inoremap jj <Esc>:w<CR>

	" Forget about multiple captial J - do no operation if that key is spammed
	nnoremap JJJJ <Nop>

	" Highlight the parentheses
	highlight MatchParen ctermbg=4
]]


-- [CoC completion related mappings]
vim.cmd[[
  	function! s:check_back_space() abort
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

	let g:coc_snippet_next = '<tab>'

	" Remap enter while CocCompletion is open in order to get the recent selection
	inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
	inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"

	" remap for complete to use tab and <cr>
	inoremap <silent><expr> <TAB>
				\ coc#pum#visible() ? coc#pum#next(1):
				\ <SID>check_back_space() ? "\<Tab>" :
				\ coc#refresh()
	inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
	inoremap <silent><expr> <c-space> coc#refresh()

	" CocCompletion color
	hi CocSearch ctermfg=12 guifg=#18A3FF
	hi CocMenuSel ctermbg=109 guibg=#13354A

]]

-- fixme: add the settings for augroup
vim.cmd[[
	" Setting the color column for specific file types
	augroup any
		autocmd FileType * set tabstop=2 colorcolumn=200 shiftwidth=2 noexpandtab textwidth=199
	augroup END

	augroup cc
		autocmd BufRead,BufNewFile *.h,*.c set filetype=c
		autocmd FileType c set colorcolumn=80 tabstop=8 shiftwidth=8 noexpandtab nocursorcolumn textwidth=79
	augroup END

	augroup cp
		autocmd BufRead,BufNewFile *.hpp,*.cpp set filetype=cpp
		autocmd FileType cpp set colorcolumn=120 tabstop=2 shiftwidth=2 noexpandtab nocursorcolumn textwidth=119
	augroup END

	augroup python
		autocmd BufRead,BufNewFile *.py set filetype=python
		autocmd FileType python set colorcolumn=120 tabstop=4 shiftwidth=4 noexpandtab nocursorcolumn textwidth=119
	augroup END

	augroup go
		autocmd BufRead,BufNewFile *.go set filetype=go
		autocmd FileType go set colorcolumn=80 tabstop=4 shiftwidth=4 noexpandtab nocursorcolumn textwidth=79
	augroup END

	augroup ruby
		autocmd BufRead,BufNewFile *.rb set filetype=ruby
		autocmd FileType ruby set colorcolumn=80 tabstop=8 shiftwidth=8 noexpandtab nocursorcolumn textwidth=79
	augroup END

	augroup tex
		autocmd BufRead,BufNewFile *.tex set filetype=tex
		autocmd FileType tex set colorcolumn=120 tabstop=4 shiftwidth=4 noexpandtab nocursorcolumn textwidth=119
	augroup END

	augroup lisp
		autocmd BufRead,BufNewFile *.lisp set filetype=lisp
		autocmd FileType lisp set colorcolumn=120 tabstop=8 shiftwidth=8 noexpandtab nocursorcolumn textwidth=119
		"autocmd FileType lisp let b:delimitMate_autoclose = 0
	augroup END

	" Adding the time addition shortcut
	:nnoremap <F10> "=strftime("%a, %d %b %Y %H:%M:%S %z") . " : "<CR>P
	:inoremap <F10> <C-R>=strftime("%a, %d %b %Y %H:%M:%S %z") . " : "<CR>
]]

-- settings for tagbar
vim.cmd[[
	" Tagbar configuration
	nnoremap <silent> <F7> :Tagbar<CR>
]]

-- settings related to git blame delay
vim.cmd[[
	let g:gitblame_delay = 10 " 10 milliseconds
]]

-- show branch information in the status line if branch information is present
vim.cmd[[
	function! StatuslineGitBranch()
		let b:gitbranch=""
		if &modifiable
			try
				lcd %:p:h
			catch
				return
			endtry
			let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
			lcd -
			if l:gitrevparse!~"fatal: not a git repository"
				let b:gitbranch="[".substitute(l:gitrevparse, '\n', '', 'g')."]"
			endif
		endif
	endfunction

	augroup GetGitBranch
		autocmd!
		autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
	augroup END

	set statusline=\ %f%m%r%h%w\ %{b:gitbranch}\ %=%({%{&ff}\|%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\")}%k\|%Y}%)\ %([%l,%v][%p%%]\ %)
]]

-- Setting the keymappings for floaterm
vim.cmd[[
	let g:floaterm_title = " ostream-shell "
	let g:floaterm_width = 0.9
	let g:floaterm_height = 0.9
	let g:floaterm_keymap_toggle = '<F12>'
]]

-- remove any trailing whitespace in the lines
vim.cmd[[
	" Remove any trailing whitespace that is in the file
	autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
]]

-- configuration for vim mundo - needed for undoing for all types of files
vim.cmd[[
	set undofile
	set undodir=~/.undo
]]
vim.cmd[[ map! <silent> <F2> <ESC>:MundoToggle<CR> ]]
vim.cmd[[ map <silent> <F2> :MundoToggle<CR> ]]
