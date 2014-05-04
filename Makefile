run: pull link

link:
	ln -s ~/.vim/vimrc ~/.vimrc

pull:
	git pull -r
	git submodule update --init
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	git submodule foreach git pull --rebase
