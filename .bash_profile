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

alias su='sudo '
alias ..='cd ..'
alias trash='rm -r ~/.Trash/*;'
alias home='go ~'

alias rb='ruby'
alias py='python'

alias showfiles='defaults write com.apple.Finder AppleShowAllFiles YES; killall -HUP Finder'
alias hidefiles='defaults write com.apple.Finder AppleShowAllFiles NO; killall -HUP Finder'

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
# Git Fun
#-----------------

alias gitnew='git init'
alias gitstat='git status'

# Get the last commit message

gitlastcommit() {
	lastCommit=$(git log --name-status HEAD^..HEAD | grep "^\s\{4\}"  | head -n 1 | sed "s:^ *::")
	echo "$lastCommit"
}
alias gitlc='gitlastcommit'

# Add and commit together

gitcommit() {
    git add --all :/
    if [ $# -eq 0 ]; then
        git commit -am "updated repository"
    else
        git commit -am "$1"
    fi
}
alias gitcom='gitcommit'

# Pull and push together

gitsync() {
    git pull
    git push
}

# Add, commit, pull, and push together

gitall() {
    if [ $# -eq 0 ]; then
        gitcommit "updated repository"
    else
        gitcommit "$1"
    fi
    gitsync
}

# Make a branch if it doesn't exist
# Checkout the branch

gitbranch() {
    if [ $# -eq 0 ]; then
        git branch
        return
    fi
    branch=$(git branch | grep $1)
    if [ -z "$branch" ]; then
        git checkout -b $1
    elif [ $(echo "$branch" | grep ^[^*]) ]; then
        git checkout $1
    fi
}

# Branch to master
# Merge then delete current branch
# If -a flag passed, do a gitall after branch to master

gitpheonix() {
    branchName=$(git branch | grep ^\* | sed "s:\* ::")
    gitbranch master
    git merge $branchName
    git branch -d $branchName
    
    if [ $# -eq 1 -a $1 = "-a" ]; then
        lastCommit=gitlastcommit
        gitall "$lastCommit"
    fi
}
alias gitpx='gitpheonix'
alias gitpxa='gitpheonix -a'