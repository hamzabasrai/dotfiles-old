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

setup_vim_env() {
    
    declare -r VUNDLE_DIR="$HOME/.vim/plugins/Vundle.vim"
    declare -r VUNDLE_REPO_URL="https://github.com/VundleVim/Vundle.vim"
    
    eval \
        rm -rf $VUNDLE_DIR \
        && git clone --quiet $VUNDLE_REPO_URL $VUNDLE_DIR \
        && printf '\n' | vim +PluginInstall +qall 
}

create_symlinks
setup_vim_env &> /dev/null

source ~/.profile
