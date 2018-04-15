#!/bin/bash

files=".bash_aliases .bash_exports .bash_options .bash_colors .bash_prompt .bashrc .gitignore .gitconfig .gitattributes .hushlogin .inputrc .curlrc .profile"

echo "Backing up files"
mkdir -p ~/dotfiles_old

cd ~/dotfiles

for file in $files; do
  if [ -f ~/$file ]; then
    mv ~/$file ~/dotfiles_old
    echo "$file backed up"
  fi
done

for file in $files; do
  ln -s ~/dotfiles/$file ~/$file
  echo "Linking $file"
done

source ~/.profile
