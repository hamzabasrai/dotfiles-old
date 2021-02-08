# Oxide theme for Zsh
#
# Author: Diki Ananta <diki1aap@gmail.com>
# Repository: https://github.com/dikiaap/dotfiles
# License: MIT

# Prompt:
# %F => Color codes
# %f => Reset color
# %~ => Current path
# %(x.true.false) => Specifies a ternary expression
#   ! => True if the shell is running with root privileges
#   ? => True if the exit status of the last command was success
#
# Git:
# %a => Current action (rebase/merge)
# %b => Current branch
# %c => Staged changes
# %u => Unstaged changes
#
# Terminal:
# \n => Newline/Line Feed (LF)
# %D{%I:%M %p} => Current time of day in 12 hour format 

setopt PROMPT_SUBST

autoload -U add-zsh-hook
autoload -Uz vcs_info

# Use True color (24-bit) if available.
turquoise="%F{73}"
orange="%F{179}"
red="%F{167}"
green="%F{107}"

# VCS style formats.
FMT_UNSTAGED=" %{$orange%}●"
FMT_STAGED=" %{$green%}✚"
FMT_ACTION="%f(%{$green%}%a%f)"
FMT_VCS_STATUS="%fon %{$turquoise%}%b%u%c%f"

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr    "${FMT_UNSTAGED}"
zstyle ':vcs_info:*' stagedstr      "${FMT_STAGED}"
zstyle ':vcs_info:*' actionformats  "${FMT_VCS_STATUS} ${FMT_ACTION}"
zstyle ':vcs_info:*' formats        "${FMT_VCS_STATUS}"
zstyle ':vcs_info:*' nvcsformats    ""
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

# Check for untracked files.
+vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
            git status --porcelain | grep --max-count=1 '^??' &> /dev/null; then
        hook_com[staged]+="%f %{$red%}●"
    fi
}

prompt_precmd() {
    # Pass a line before each prompt
    print -P ''
}

virtualenv_prompt_info() {
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "venv:%{$orange%}${VIRTUAL_ENV:t}"
}

# Disables prompt mangling in virtualenv/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

# Executed before each prompt.
add-zsh-hook precmd vcs_info
add-zsh-hook precmd prompt_precmd

RPROMPT='$(virtualenv_prompt_info)'                 # Active Python virtualenv

PROMPT='%D{%I:%M%p} '                               # Current time of day in 12 hour format
PROMPT+='%{$green%}%~ '                             # Current path
PROMPT+=$'${vcs_info_msg_0_}\n'                     # Git Repo Info
PROMPT+='%(?.%{%F{white}%}.%{$red%})%(!.#.>)%f '    # Prompt character > or # if root