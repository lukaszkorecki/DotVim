bundleDir := bundle
repos =  \
	Shougo/vimproc.vim \
	godlygeek/tabular \
	jgdavey/vim-blockle \
	kana/vim-textobj-user \
	nelstrom/vim-textobj-rubyblock \
	pangloss/vim-javascript \
	rodjek/vim-puppet \
	scrooloose/syntastic \
	tpope/vim-fugitive \
	tpope/vim-markdown \
	tpope/vim-surround \
	vim-ruby/vim-ruby \
	vim-scripts/JSON.vim \
	clones/vim-nginx \
	kchmck/vim-coffee-script \
	fatih/vim-go \
	othree/html5.vim \
	mustache/vim-mustache-handlebars \
	ludovicchabant/vim-gutentags \
	tpope/vim-eunuch \
	mattn/emmet-vim \
	ingydotnet/yaml-vim \
	chase/vim-ansible-yaml \
	Glench/Vim-Jinja2-Syntax \
	# foo

.PHONY: run link pull init-modules sync neo

run: pull init-modules sync link neo

link:
	ln -f -s ~/.vim/vimrc ~/.vimrc

pull:
	git pull -r -u origin master

init-modules:
	mkdir -p $(bundleDir)
	$(foreach repo,$(repos), \
	 	git clone git@github.com:$(repo).git $(bundleDir)/$(notdir $(repo)) || true  ;)

sync:
	$(foreach repo,$(repos), \
		cd $(bundleDir)/$(notdir $(repo)) ; git pull -u origin master ; cd -;)

neo:
	ln -s ~/.vim/nvimrc ~/.nvimrc
	ln -s ~/.vim ~/.nvim
