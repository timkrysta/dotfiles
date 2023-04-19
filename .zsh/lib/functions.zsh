# see your top 10 most used commands:
function zsh_stats most_used_commands() {
  history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

# Cross platform open command
function open_command() {
  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
                open_cmd='cmd.exe /c start ""'
                [[ -e "$1" ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  ${=open_cmd} "$@" &>/dev/null
}


# Source file if exists
function source_or_fail {
  local file_to_source
  file_to_source="$1"
  # -f file       True if file exists and is a regular file.
  # -e file       True if file exists (regardless of type).
  if [ -f $file_to_source ]; then
    # source is a synonym for dot/period '.' in bash, but not in POSIX sh, 
    # so for maximum compatibility use the period.
    . $file_to_source
  else
    echo "[zsh]: 404: File ${file_to_source} not found."
  fi
}



# Source file if exists
function source_whole_dir {
  local dir_to_source
  dir_to_source="$1"
  # -d dir       True if dir exists
  if [ -d $dir_to_source ]; then
    # https://stackoverflow.com/questions/91368/checking-from-shell-script-if-a-directory-contains-files
    if [ -n "$(ls -A $dir_to_source 2>/dev/null)" ]; then

      #echo "[zsh]: Dir ${dir_to_source} contains a file (or is a file)."
      for file in $dir_to_source/*.zsh; do
        . "$file"
      done

    else
      echo "[zsh]: Dir ${dir_to_source} empty of not exist."
    fi
  else
    echo "[zsh]: Dir ${dir_to_source} not found."
  fi
}




#######################################
# Check if command exists.
# Arguments:
#   Commands, to test
# Returns:
#   true if exists, false does not exist.
#######################################
function command_exists() {
	command -v "$@" >/dev/null 2>&1
}






# take functions

# mkcd is equivalent to takedir
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

# TODO: add extract command
# Curl some URL and download it, extract, rm dir and cd into extracted one
function takeurl() {
  local data thedir
  # mktemp -- make temporary file name (unique)
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -1)"
  rm "$data"
  cd "$thedir"
}

# Git clone and cd into
function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

# Short for all above functions. 
# Decides which to run by checking passed argument
function take() {
  if [[ $1 =~ ^(https?|ftp).*\.tar\.(gz|bz2|xz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}




# 
# Set variable "$1" to default value "$2" if "$1" is not yet defined.
#
# Arguments:
#    1. name - The variable to set
#    2. val  - The default value
# Return value:
#    0 if the variable exists, 3 if it was set
#
function default() {
    (( $+parameters[$1] )) && return 0
    typeset -g "$1"="$2"   && return 3
}

#
# Set environment variable "$1" to default value "$2" if "$1" is not yet defined.
#
# Arguments:
#    1. name - The env variable to set
#    2. val  - The default value
# Return value:
#    0 if the env variable exists, 3 if it was set
#
function env_default() {
    [[ ${parameters[$1]} = *-export* ]] && return 0
    export "$1=$2" && return 3
}



#
# Get the value of an alias.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1 (if it has one).
# Return value:
#    0 if the alias was found,
#    1 if it does not exist
#
function alias_value() {
    (( $+aliases[$1] )) && echo $aliases[$1]
}

#
# Try to get the value of an alias,
# otherwise return the input.
#
# Arguments:
#    1. alias - The alias to get its value from
# STDOUT:
#    The value of alias $1, or $1 if there is no alias $1.
# Return value:
#    Always 0
#
function try_alias_value() {
    alias_value "$1" || echo "$1"
}





# A timer which counts till the specified number of seconds, and then rings a bell. 
# Equivalent of bset timer xbon google on terminal (without requiring internet connection).
# NOTE: that is not perfect because of additional time needed to run this function +0.3 sec 
function count() { 
  total=$1 
  for ((i=total; i>0; i--)); do sleep 1; printf "Time remaining $i secs \r"; done 
  echo -e "\a" 
}

# If you pass 'up' without number you will go one up
# Needn't to do cd ../../.. any longer. Just do: up 3 
function up () {
  times=$1
  P=$PWD/..
  for ((i=1; i < times; i++))
  do
    P=$P/..
  done
  cd $P
}

# Rename and open in VS Code
function mv_and_code mv_code mvcode rename_code() {
  if ! [[ $# -eq 2 ]]; then
    echo "Arguments were not specified!"
    echo "Running 'which mv_and_code'"
    echo ""
    which mv_and_code
  else
    sudo mv $1 $2 && code $2
  fi
}



##
# Get file size
##
#
# Determine size of a file/files or total size of a directory
#
# ls -l    displays size as in finder 'Get Info'
# du -sh   displays size on disk
#
function fs getsize get_size get_file_size getfilesize get_files_size() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}
# Primitive version of above
#function get_file_size get_files_size() {
#  du -sh "$@"
#}




# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}
# Same as above but without piping to 'less'
function tree() {
  /usr/local/bin/tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@"
}




# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified.";
		return 1;
	fi;

	local domain="${1}";
	echo "Testing ${domain}…";
	echo ""; # newline

	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" -servername "${domain}" 2>&1);

	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_aux, no_header, no_issuer, no_pubkey, \
			no_serial, no_sigdump, no_signame, no_validity, no_version");
		echo "Common Name:";
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//" | sed -e "s/\/emailAddress=.*//";
		echo ""; # newline
		echo "Subject Alternative Name(s):";
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2;
		return 0;
	else
		echo "ERROR: Certificate not found.";
		return 1;
	fi;
}



# Start an HTTP server from a directory, optionally specifying the port
function pyserver() {
	local port="${1:-8000}";
	sleep 1 && open "http://localhost:${port}/" &
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port";
}

# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port="${1:-4000}";
	local ip=$(ipconfig getifaddr en1);
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}


. $ZSH/lib/functions/encoding.zsh
. $ZSH/lib/functions/trash.zsh
