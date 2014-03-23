FILES := vim vimrc

do: install link

link:
	ln -s ~/.DotVim/vimrc ~/.vimrc
	ln -s ~/.DotVim ~/.vim

install:
	git pull -r
	git submodule update --init
	git submodule foreach git reset --hard
	git submodule foreach git checkout master
	git submodule foreach git pull --rebase
