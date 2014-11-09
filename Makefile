bundleDir := _bundle
repos =  \
	vim-ruby/vim-ruby \
	altercation/vim-colors-solarized \
	Shougo/vimproc.vim \
	kien/ctrlp.vim \
	rodjek/vim-puppet \
	godlygeek/tabular \
	lukaszkorecki/vim-sparkup

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
		cd _$(bundleDir)/$(notdir $(repo)) ; git pull -u origin master ; cd -;)
