# migrate from before
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
# export PATH="/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/bin:$HOME/.rbenv/bin:${ANT_HOME}/bin:$HOME/bin/sdk/tools:$HOME/bin/sdk/platform-tools:$HOME/bin/ant/bin:$HOME/bin/cordova-android/bin:$PATH:/usr/local/bin:/Applications/Genymotion Shell.app/Contents/MacOS/:/Applications/Genymotion.app/Contents/MacOS/"

# 常用的 alias

# alias part
# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

# be nice
alias please="sudo"

# `cat` with beautiful colors. requires Pygments installed.
#                                       sudo easy_install Pygments
# alias cat="pygmentize -O style=monokai -f console256 -g"
# alias c="pygmentize -O style=monokai -f console256 -g"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"


# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# file size
# alias fs="stat -f \”%z bytes\""

alias f="open -a Finder"

alias -g is26="ssh -R 52698:localhost:52698 sivagao@is26.com"
alias -g wdjrelay="ssh -p 2222 gaohailang@hy-relay2.wandoujia.com"
alias -g hosts="sudo vim /etc/hosts"

alias nw=/Applications/node-webkit.app/Contents/MacOS/node-webkit

# /usr/bin/login -f <your user name> when git brokeb