# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias -- -="cd -"

alias hosts='sudo $EDITOR /etc/hosts'

### ls
# use coreutils `ls` if possible…
hash gls >/dev/null 2>&1 || alias gls="ls"

###
# GIT STUFF

# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# Recursively delete `.DS_Store` files
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

alias diskspace_report="df -P -kHl"

# File size
alias fs="stat -f \"%z bytes\""

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Shortcuts
alias lgit="find . -name .git 2>/dev/null | map dirname"