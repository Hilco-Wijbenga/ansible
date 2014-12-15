alias ls='/bin/ls --color -F'
alias l='ls -l'
alias ll='l -A'

export FIGNORE=CVS:\~:.o:.svn:.git

export PS1='[$(date +"%Y-%m-%d %H:%M:%S")] \[\033[01;32m\]\u@\h\[\033[01;34m\] \w\n\$\[\033[00m\] '
