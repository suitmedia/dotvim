backup your own .vim first

  mv ~/.vim ~/.vim_old

clone the config

  git clone git@github.com:Suitmedia/dotvim.git ~/.vim

compile command-t

  cd ~/.vim/ruby/command-t
  rm *.o
  ruby extconf.rb
  make

install ack

  sudo apt-get install ack-grep
