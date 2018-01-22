# Editing

if [[ ! "$SSH_TTY" ]] && is_osx; then
  export EDITOR='mvim'
  export LESSEDIT='mvim ?lm+%lm -- %f'
else
  export EDITOR='vim'
fi

export VISUAL="$EDITOR -f"
alias q="$EDITOR"
alias qv="q $DOTFILES/link/.{,g}vimrc +'cd $DOTFILES'"
alias qs="q $DOTFILES"

function vim-add-module() {
    if [ -z "${1}" -o -z "${2}" ]; then
        echo "Usage: \`vim-add-module url name\`";
        return 1;
    fi;
    cd $DOTFILES && git submodule add $1 link/.vim/bundle/$2 && cd -
}
