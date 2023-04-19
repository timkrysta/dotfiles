#######################################
# Trash related four functions
#######################################
function trash_init() {
  if [ -n "${TRASH}" ]; then
    # Variable not empty - do nothing
    return
  else
    # Variable empty - set it
    # Detect OS
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
      # Linux
      [ -d $HOME/.local/share/Trash ] && TRASH="$HOME/.local/share/Trash" # Debian
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      # Mac OSX
      [ -d $HOME/.Trash ] && TRASH="$HOME/.Trash" # MacOS
    elif [[ "$OSTYPE" == "cygwin" ]]; then
      # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
      # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
      # I'm not sure this can happen.
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
      # ...
    else
      # Unknown.
    fi

    # Handle trash not found
    if [ -z "${TRASH}" ]; then
      # empty variable
      mkdir -p $HOME/.Trash && [ -d $HOME/.Trash ] && TRASH="$HOME/.Trash"
    fi


    BIN=$TRASH
    export TRASH BIN
  fi
  #debug 
  #echo "[lib/functions/trash.zsh]: [test] TRASH path: $TRASH" 
}

trash_init



function empty_bin emptybin binempty empty_trash trash_empty trash-empty() {
  rm -rf $TRASH/* && echo "Emptied Trash"

  #[ -d $HOME/.local/share/Trash ] && rm -rf ~/.local/share/Trash/* && echo "Emptied Shared Trash" 
  #[ -d $HOME/.Trash ] && rm -rf ~/.Trash/* && echo "Emptied Trash" 

  # If TRASH variable is empty
  #echo "Sorry we are unable to determine your trash location"
  #echo "You can set shell variable manualy: TRASH='/path/to/trash' in ~/.zshenv"
}

function bin_ls binls trash_ls trash_list trash-list() {
  ls -lAh $TRASH
}

function bin_put binput binrm bin_mv trash_put trash-put() {
  if [ -w "$@" ]; then
    # echo "Writable"
    mv "$@" $TRASH
  else
    # echo "Not Writable"
    # Use sudo
    sudo mv "$@" $TRASH
  fi  
}