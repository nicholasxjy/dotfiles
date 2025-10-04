
# Colorize grep output (good for log files) - #cspell:disable
alias grep 'grep --color=auto'
alias egrep 'egrep --color=auto'
alias fgrep 'fgrep --color=auto'


# Confirm before overwriting
alias cp 'cp -Ri'
alias mv 'mv -i'
alias rm 'rm -i'

# Create/delete directories
alias md 'mkdir -p'
alias rd 'rmdir -p'

# Navigation
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'
alias ...... 'cd ../../../../..'
alias l 'eza --long --all --header --git --icons --no-permissions --no-time --no-user --no-filesize --group-directories-first'
alias ll 'eza -lagh --git --icons --no-user'
alias la 'eza -lagh --git --icons --no-user --sort modified'
alias cll 'clear; and eza --long --all --header --git --icons --no-permissions --no-time --no-user --no-filesize --group-directories-first'

# Tree view
alias tree 'eza -Ta --icons --ignore-glob="node_modules|.git|.vscode|.DS_Store"'
alias ltd 'eza -TaD --icons --ignore-glob="node_modules|.git|.vscode|.DS_Store"'




# Editors and Utilities
alias du dua
alias wget 'wget -c'

# Network shortcuts/aliases and utilities
alias ip "dig +short myip.opendns.com @resolver1.opendns.com" # dumps [YOUR PUBLIC IP] [URL IP]
alias ipl "ipconfig getifaddr en0" #internal network IP
alias ips "ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias sniff "sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump "sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
alias whois "grc whois" # colorized whois

# SSH and localhost
alias hostfile 'eval sudo $EDITOR /etc/hosts'



alias nvim=~/nvim-macos-arm64/bin/nvim
