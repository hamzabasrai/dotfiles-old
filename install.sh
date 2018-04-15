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
  )

	
  for file in ${FILES_TO_SYMLINK[@]}; do
    
    sourceFile="$(pwd)/$file"
    targetFile="$HOME/.$(printf "%s" "$file" | sed "s/.*\/\(.*\)/\1/g")"

    if [ ! -e "$targetFile" ]; then
      eval "ln -sf $sourceFile $targetFile"  
    fi
  done
}

create_symlinks

source ~/.profile
