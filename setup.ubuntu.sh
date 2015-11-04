#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# needed for grader.js
npm install cheerio
npm install commander

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg
# pdf2txt
sudo apt-get install python-pdfminer

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/Grogoyle/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

git config --global user.name "Grogoyle"
git config --global user.email "steve@grog.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'
git init

git clone git@github.com/Grogoyle/coursera.git
git clone git@github.com/Grogoyle/bitstarter.git

# git commit -m "first commit"
# git remote add origin git@github.com:Grogoyle/setup.git
# git remote add upstream https://github.com/octocat/Spoon-Knife.git
# git push -u origin master
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

