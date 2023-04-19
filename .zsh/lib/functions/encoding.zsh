function rand_base64 randbase64 random_base64() {
  openssl rand -base64 $1
}

function rand_hex randhex random_hex() {
  openssl rand -hex $1
}

function encode64 e64 b64encode base64encode base64_encode() {
  if [[ $# -eq 0 ]]; then
    cat | base64
  else
    echo "$@" | base64
  fi
}
function decode64 d64 b64decode base64decode base64_decode() {
  if [[ $# -eq 0 ]]; then
    cat | base64 --decode
  else
    echo "$@" | base64 --decode
  fi
}

##
# Mis-spelled commands
##
alias base64enocde='encode64'
alias base64deocde='decode64'



# These functions are commented cuz is better in urltools.plugin.zsh
#

# If you want to encode spaces as +, replace ul.quote with ul.quote_plus.
#
# Usage:
#   $ urlencode 'q werty=/;'
#function urlencode() { 
#  python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))" "$@"
#}
# Alternative:
#   echo -n "%21%20" | python3 -c "import sys; from urllib.parse import unquote; print(unquote(sys.stdin.read()));"
#
#   $ urldecode 'q+werty%3D%2F%3B'
#function urldecode() { 
#  python3 -c "import sys, urllib.parse as ul; print(ul.unquote_plus(sys.argv[1]))" "$@"
#}

