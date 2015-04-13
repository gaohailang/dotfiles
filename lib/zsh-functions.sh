
# Find files and exec commands at them.
# $ find-exec .coffee cat | wc -l
# # => 9762
function find-exec() {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

# Count code lines in some directory.
# $ loc py js css
# # => Lines of code for .py: 3781
# # => Lines of code for .js: 3354
# # => Lines of code for .css: 2970
# # => Total lines of code: 10105
function loc() {
  local total
  local firstletter
  local ext
  local lines
  total=0
  for ext in $@; do
    firstletter=$(echo $ext | cut -c1-1)
    if [[ firstletter != "." ]]; then
      ext=".$ext"
    fi
    lines=`find-exec "*$ext" cat | wc -l`
    lines=${lines// /}
    total=$(($total + $lines))
    echo "Lines of code for ${fg[blue]}$ext${reset_color}: ${fg[green]}$lines${reset_color}"
  done
  echo "${fg[blue]}Total${reset_color} lines of code: ${fg[green]}$total${reset_color}"
}

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
function ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

function size() {
  du -sh "$@" 2>&1 | grep -v '^du:'
}

# Determines the max number of tweeple who saw some tweet.
# If tweet x was retweeted by users A (500 followers) and B (10 followers),
# influence would be 500 + 10 + x-authors-followers.
# $ tweet-influence https://twitter.com/chaplinjs/status/303718187437015040
# # => 11851

# $ git log --no-merges --pretty=format:"%ae" | stats
# 514 a@example.com
# 200 b@example.com
function stats() {
  sort | uniq -c | sort -r
}

# Shortcut for searching commands history.
function hist() {
  history 0 | grep $@
}

# Execute commands for each file in current directory.
function each() {
  for dir in *; do
    echo "${dir}:"
    cd $dir
    $@
    cd ..
  done
}

# Pack files with zip and password.
function zip-pass() {
  zip -e $(basename $PWD).zip $@
}

# Compress files to one .tar.gz archive.
function pack-tar() {
  [[ -z "$1" ]] && echo "Usage: pack-tar file1 [file2...]" && exit 1
  archive="archive.tar.gz"
  tar -zcvf $archive $@
}

# Uncopress .tar.gz archive.
function unpack-tar() {
  tar -zxvf $1
}

# Shortens GitHub URLs.
# By Sorin Ionescu <sorin.ionescu@gmail.com>
function gitio() {
  local url="$1"
  local code="$2"

  [[ -z "$url" ]] && print "usage: $0 url code" >&2 && exit
  [[ -z "$code" ]] && print "usage: $0 url code" >&2 && exit

  curl -s -i 'http://git.io' -F "url=$url" -F "code=$code"
}

# 4 lulz.
function compute() {
  while true; do head -n 100 /dev/urandom; sleep 0.1; done \
    | hexdump -C | grep "ca fe"
}

# functions
# Create a new directory and enter it
function md() {
     mkdir -p "$@" && cd "$@"
}
# find shorthand
function f() {
    find . -name "$1"
}
# Start an HTTP server from a directory, optionally specifying the port
function server() {
     local port="${1:-8000}"
     open "http://localhost:${port}/"
     # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
     # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
     python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function localhost(){
  local port="${1:-8000}"
  static .
  open "http://localhost:${port}/"
}

function clone {
  # customize username to your own
  local username="ghlndsl"

  local url=$1;
  local repo=$2;

  if [[ ${url:0:4} == 'http' || ${url:0:3} == 'git' ]]
  then
    # just clone this thing.rm
    repo=$(echo $url | awk -F/ '{print $NF}' | sed -e 's/.git$//');
  elif [[ -z $repo ]]
  then
    # my own stuff.
    repo=$url;
    url="git@github.com:$username/$repo";
  else
    # not my own, but I know whose it is.
    url="git@github.com:$url/$repo.git";
  fi

  git clone $url $repo && cd $repo && subl .;
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# Syntax-highlight JSON strings or files
function json() {
     if [ -p /dev/stdin ]; then
          # piping, e.g. `echo '{"foo":42}' | json`
          python -mjson.tool | pygmentize -l javascript
     else
          # e.g. `json '{"foo":42}'`
          python -mjson.tool <<< "$*" | pygmentize -l javascript
     fi
}
# Escape UTF-8 characters into their 3-byte format
function escape() {
     printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
     echo # newline
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
     perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
     echo # newline
}
function openurl(){
     if [ $2 ]
     then
       url=$1"&host_ports=$2"
     fi
     open -a google\ chrome ${url}
}

function win7ie8(){
     local url="http://www.browserstack.com/start#os=Windows&os_version=7&browser=IE&browser_version=8.0&zoom_to_fit=true&resolution=1024x768&speed=1&url=$1&start=true"
     openurl $url $2
}
# Browserstack shortcuts, now with added hotness thanks to the Browserstack team.
# Note, a trial or paid for account is needed for this to work
# Usage: ipad3 "http://www.google.com", win7ie8 "http://www.google.com" etc.

# For local server running on port 3000, use like this
# Usage: ipad3 "http://localhost:3000" "localhost,3000,0", win7ie8 "http://localhost:3000" "localhost,3000,0" etc.

# For local server running on apache with ssl as staging.example.com and https://staging.example.com
# Usage: ipad3 "http://staging.example.com" "staging.example.com,80,0,staging.example.com,443,1", win7ie8 "http://staging.example.com" "staging.example.com,80,0,staging.example.com,443,1" etc.

