#-----------------
# Prompt and ls
#-----------------

export CLICOLOR=1

source "${HOME}/.ls_colors"
source "${HOME}/.custom_prompt"

#-----------------
# Aliases
#-----------------

alias prn='nano ~/.bash_profile' # go ahead, make fun of nano :)
alias prs='source ~/.bash_profile'

alias ncol='nano ~/.ls_colors'
alias scol='source ~/.ls_colors'

alias nprt='nano ~/.custom_prompt'
alias sprt='source ~/.custom_prompt'

alias su='sudo '
alias ..='cd ..'
alias trash='rm -r ~/.Trash/*;'
alias home='go ~'

alias rb='ruby'
alias py='python'

alias showfiles='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias hidefiles='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

#-----------------
# Git Fun
#-----------------

alias gitnew='git init'
alias gitstat='git status'

# Add and commit together

gitadd() {
    git add .
    if [ $# -eq 0 ]; then
        git commit -am "updated repository"
    else
        git commit -am "$1"
    fi
}

# Pull and push together

gitsync() {
    git pull
    git push
}

# Add, commit, pull, and push together

gitall() {
    if [ $# -eq 0 ]; then
        gitadd "updated repository"
    else
        gitadd $1
    fi
    gitsync
}

# Make a branch if it doesn't exist
# Checkout the branch

gitbranch() {
    if [ $# -eq 0 ]; then
        return 1
    fi
    branches=$(git branch | grep $1)
    if [ -z $branches ]; then
        git checkout -b $1
    else
        git checkout $1
    fi
}

#-----------------
# Directory Fun
#-----------------

# Print contents of ./ or passed in directory name
# -f or --finder flag will open it with finder

vw() {
    clear
    echo
    if [ $# -eq 0 ]; then
        ls -1
    elif [ $# -eq 1 ]; then
        if [ $1 = "-f" -o $1 = "--finder" ]; then
            ls -1
            open ./
        else
            ls -1 $1
        fi
    else
        if [ $1 = "-f" -o $1 = "--finder" ]; then
            ls -1 $2
            open $2
        elif [ $2 = "-f" -o $2 = "--finder" ]; then
            ls -1 $1
            open $1
        fi
    fi
    echo
}

# Change to a directory and view its contents
# -f or --finder flag will open it with finder

go() {
    if [ $# -eq 0 ]; then
        return 1
    elif [ $# -eq 1 ]; then
        cd $1
        vw
    else
        if [ $1 = "-f" -o $1 = "--finder" ]; then
            open $2
            go $2
        elif [ $2 = "-f" -o $2 = "--finder" ]; then
            open $1
            go $1
        fi
    fi
}

# Open current directory or passed in directory name

op() {
    if [ $# -eq 0 ]; then
        open ./
    else
        open $1
    fi
}

# Make directory and change to it

mkcd() {
    if [ $# -gt 0 ]; then
        mkdir $1
        cd $1
    fi
}

# Remove directory

rmd() {
    if [ $# -gt 0 ]; then
        rm -r $1
    fi
}

#-----------------
# Clear
#-----------------

# Will clear the screen once, or num times if number passed in

cl () {
    if [ $# -eq 0 ]; then
        clear
    else
        num=$1
        while [ $num -gt 0 ]; do
            clear
            ((num -= 1))
        done
    fi
}