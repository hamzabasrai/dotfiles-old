#!/bin/bash

create_symlinks() {
    
    declare -a FILES_TO_SYMLINK=(
        "shell/bash_aliases"
        "shell/bash_exports"
        "shell/bash_logout"	  
        "shell/bash_options"
        "shell/bash_prompt"	  
        "shell/bashrc"
        "shell/inputrc"
        "shell/profile"

        "git/gitattributes"
        "git/gitconfig"  
        "git/gitignore"

        "vim/vimrc"
    )

	
    for file in ${FILES_TO_SYMLINK[@]}; do
        sourceFile="$(pwd)/$file"
        targetFile="$HOME/.$(printf "%s" "$file" | sed "s/.*\/\(.*\)/\1/g")"
        
        if [ ! -e "$targetFile" ]; then
            eval "ln -sf $sourceFile $targetFile"  
        fi
    done
}

create_vim_directories() {
    declare -r SWAP_DIR="$HOME/.vim/swaps"
    declare -r BACKUP_DIR="$HOME/.vim/backups"

    eval \
        rm -rf $SWAP_DIR $BACKUP_DIR \
        && mkdir $SWAP_DIR \
        && mkdir $BACKUP_DIR
}

echo "Creating symlinked dotfiles"
create_symlinks

echo "Setting up Vim directories"
create_vim_directories

echo "Dotfiles successfully installed"
source ~/.profile
