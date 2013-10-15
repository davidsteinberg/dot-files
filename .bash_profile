# Go ahead, make fun of nano :)

alias prn='nano ~/.bash_profile'
alias prs='source ~/.bash_profile'

alias su='sudo '
alias ..='cd ..'
alias trash='rm -r ~/.Trash/*;'
alias vwf='vw -f '
alias gof='go -f '
alias home='go ~'

alias rb='ruby'
alias py='python'

# Make directory and change to it
mkcd() {
    if [ $# -gt 0 ]; then
        mkdir $1
        cd $1
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

# Remove directory
rmd() {
    if [ $# -gt 0 ]; then
        rm -r $1
    fi
}

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

# Colors

export CLICOLOR=1

# Regular

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold

BoldBlack='\e[1;30m'   # Black
BoldRed='\e[1;31m'     # Red
BoldGreen='\e[1;32m'   # Green
BoldYellow='\e[1;33m'  # Yellow
BoldBlue='\e[1;34m'    # Blue
BoldPurple='\e[1;35m'  # Purple
BoldCyan='\e[1;36m'    # Cyan
BoldWhite='\e[1;37m'   # White

# Background

BGBlack='\e[40m'       # Black
BGRed='\e[41m'         # Red
BGGreen='\e[42m'       # Green
BGYellow='\e[43m'      # Yellow
BGBlue='\e[44m'        # Blue
BGPurple='\e[45m'      # Purple
BGCyan='\e[46m'        # Cyan
BGWhite='\e[47m'       # White

EndColor='\e[0m'      # Color Reset

# Prompt

export PS1="${BoldWhite}\w : ${EndColor}"

# LS Colors

LSBlack='a'
LSRed='b'
LSGreen='c'
LSBrown='d'
LSBlue='e'
LSMagenta='f'
LSCyan='g'
LSLightGray='h'

LSBoldBlack='A'
LSBoldRed='B'
LSBoldGreen='C'
LSBoldBrown='D'
LSBoldBlue='E'
LSBoldMagenta='F'
LSBoldCyan='G'
LSBoldLightGray='H'
LSDefaultColor='x'

# Each pair of colors is foreground then background

# 1. directory
# 2. symbolic link
# 3. socket
# 4. pipe
# 5. executable
# 6. block special
# 7. character special
# 8. executable with setuid bit set
# 9. executable with setgid bit set
# 10. directory writable to others, with sticky bit
# 11. directory writable to others, without sticky bit

export LSCOLORS=\
${LSBoldCyan}${LSDefaultColor}\
${LSBoldLightGray}${LSDefaultColor}\
${LSBoldBrown}${LSDefaultColor}\
${LSBoldMagenta}${LSDefaultColor}\
${LSBoldGreen}${LSDefaultColor}\
${LSBlue}${LSCyan}\
${LSBlue}${LSBrown}\
${LSBlack}${LSRed}\
${LSBlack}${LSCyan}\
${LSBlack}${LSGreen}\
${LSBlue}${LSBrown}
