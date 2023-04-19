# Git commit function
function commit() {
  if [ -z "$1" ]; then
    # no message passed
    git commit
  else
    git commit -m "'$@'"
  fi
}

function cdl lcd cdls() {
  cd "$@" && ls -la;
}

function mkdircd mkcd mkd () {
  mkdir "$@" && cd "$@"
  # $_ - Is a Special variable set to last argument of previous command executed 
  #mkdir -p "$@" && cd "$_";
}


function erasef erasefile erase_file erase_a_file() {
  # TODO: Check if is a file and not empty if empty prompt it!
  cat /dev/null > "$@"
}

function grep_contents find_files_containing search_files_contents() {
  # grep -rnw '/path/to/somewhere/' -e 'pattern'
  # 
  # For more efficient searchign check this link !!!
  # https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux
  #
  #
  # -r or -R is recursive,
  # -n is line number, and
  # -w stands for match the whole word.
  # -l stands for "show the file name, not the result itself".
  # -e is the pattern used during the search

  if [ "$#" -eq 2 ]; then
    grep -rnw "$1" -e "$2"
  else
    echo "You need to pass 2 arguments: [PATH] [PATTERN]"
    echo "grep -rnw '/path/to/somewhere/' -e 'pattern'"
    echo ""
    echo "https://stackoverflow.com/questions/16956810/how-do-i-find-all-files-containing-specific-text-on-linux"
  fi
  
}


# Create python virtual enviroment 
function virtualenv py_venv() {
  if [[ $# -eq 0 ]]; then
    echo "Directory was not specified!"
    echo "Running 'which virtualenv'"
    echo ""
    which virtualenv
  else
    dir_name="$1"
    
    if [ ! -d "$dir_name" ]; then
      # Directory does not exist
      mkdir $dir_name
    fi
    python3 -m venv $dir_name
    cd $dir_name
    source_or_fail "bin/activate"
  fi
}
alias start_venv="source_or_fail 'bin/activate'"




# Instead of alias vim='sudo vim'
function vim() {
  # -w FILE : FILE exists and write permission is granted
  # -x FILE : FILE exists and execute (or search) permission is granted
  # -d FILE : FILE exists and is a directory
  # -e FILE : FILE exists
  # -f FILE : FILE exists and is a regular file
  # -r FILE : FILE exists and read permission is granted
  # -s FILE : FILE exists and has a size greater than zero

  # test -w filename && echo "Writable" || echo "Not Writable" # Equivalent
  if [ -w "$@" ]; then
    # echo "Writable"
    $(echo ${EDITOR}) "$@"
  else
    # echo "Not Writable"
    # Use sudo
    sudo $(echo ${EDITOR}) "$@"
  fi  
}



function upper to_upper toupper() {
  # NOTE: shell strips quotes unless you escape them
  python3 <<EOF
s="$@"
print(s.upper())
EOF
}

function lower to_lower tolower() {
  # NOTE: shell strips quotes unless you escape them
  python3 <<EOF
s="$@"
print(s.lower())
EOF
}


# realpath is the name of gnu realpath so decide what you want
function relpath realpath() { python -c "import os.path; print os.path.relpath('$1','${2:-$PWD}')" ; } 

function get_files_nr() {
  # Recursively counting files in a directory
  #find . -type f | wc -l

  # counting lines of ls (files and directories) without dotfiles/directories
  ls -1 | wc -l
}


function pwgenm pwgenmachine() {
  pwgen --secure -1 --capitalize --numerals --symbols --remove-chars='#' 15 1
}
function pwgenn pwgennormal() {
  pwgen -1 --capitalize --numerals --symbols --remove-chars='#`\|' 15 1
}