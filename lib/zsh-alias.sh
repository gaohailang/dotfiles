
# Simple clear command.
alias cl='clear'

# Process grep should output full paths to binaries.
alias pgrep='pgrep -fl'

# JSHint short-cut.
alias lint=jshint

# Useful global aliases.
alias -g 'H'='| head'     # git log H
alias -g 'T'='| tail'     # git log T
alias -g 'F'='| head -n'  # git log F 15
alias -g 'L'='| tail -n'  # git log L 10
alias -g 'C'='| wc -l'    # git log C

# Some OS X-only stuff.
if [[ "$OSTYPE" == darwin* ]]; then
  # Short-cuts for copy-paste.
  alias c='pbcopy'
  alias p='pbpaste'

  # Remove all items safely, to Trash (`brew install trash`).
  alias rm='trash'

  # Case-insensitive pgrep that outputs full path.
  alias pgrep='pgrep -fli'

  # Lock current session and proceed to the login screen.
  alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

  # Python virtualenv shortcuts.
  alias venv-init='virtualenv venv -p /usr/local/bin/python --no-site-packages'
  alias venv-activate='source venv/bin/activate'

  # Sniff network info.
  alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"


  function cded() {
    cd $1
    $EDITOR .
  }

  export NODE_PATH='/usr/local/lib/node_modules'

  # Gets password from OS X Keychain.
  # $ get-pass github
  function get-pass() {
    keychain="$HOME/Library/Keychains/login.keychain"
    security -q find-generic-password -g -l $@ $keychain 2>&1 |\
      awk -F\" '/password:/ {print $2}';
  }
fi

# Git short-cuts.
# alias ga='git add'
# alias gr='git rm'
# alias gf='git fetch'
# alias gu='git pull'
# alias gs='git status --short'
# alias gd='git diff'
# alias gds='git diff --staged'
# alias gc='git commit --message'
# alias gp='git push'
# alias gcp='git cpush'
# alias gcl='git clone'
# alias gl='git log'

# Burl: better curl shortcuts (https://github.com/visionmedia/burl).
if (( $+commands[burl] )); then
  alias GET='burl GET'
  alias HEAD='burl -I'
  alias POST='burl POST'
  alias PUT='burl PUT'
  alias PATCH='burl PATCH'
  alias DELETE='burl DELETE'
  alias OPTIONS='burl OPTIONS'
fi

BROWSER=''
unset BROWSER

# Opens file in EDITOR.
function edit() {
  local dir=$1
  [[ -z "$dir" ]] && dir='.'
  $EDITOR $dir
}