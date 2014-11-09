bundleDir := bundle
repos =  \
	Shougo/vimproc.vim \
	altercation/vim-colors-solarized \
	altercation/vim-colors-solarized \
	godlygeek/tabular \
	jgdavey/vim-blockle \
	kana/vim-textobj-user \
	kien/ctrlp.vim \
	majutsushi/tagbar \
	mattn/gist-vim \
	mattn/webapi-vim \
	nelstrom/vim-textobj-rubyblock \
	pangloss/vim-javascript \
	rodjek/vim-puppet \
	scrooloose/syntastic \
	tpope/vim-fugitive \
	tpope/vim-markdown \
	tpope/vim-surround \
	vim-ruby/vim-ruby \
	vim-scripts/JSON.vim \
	lukaszkorecki/vim-sparkup \
	clones/vim-nginx \
	kchmck/vim-coffee-script

run: pull sync link

link:
	ln -f -s ~/.vim/vimrc ~/.vimrc

pull: sync
	git pull -r -u origin master

init-modules:
	$(foreach repo,$(repos), \
	 	git clone git@github.com:$(repo).git $(bundleDir)/$(notdir $(repo)) ;)

sync:
	$(foreach repo,$(repos), \
		cd $(bundleDir)/$(notdir $(repo)) ; git pull -u origin master ; cd -;)
