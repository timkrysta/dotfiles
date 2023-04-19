## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$ZSH/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

# HISTCONTROL — A colon-separated list of values controlling how commands are saved on the history list.
# HISTFILE — The name of the file in which command history is saved; again, the default for this value is ~/.bash_history
# HISTFILESIZE — The maximum number of lines that can be within the history file.
# HISTIGNORE — A colon-separated list of patterns used to decide which command lines to be ignored. I often see general “maintenance” commands here, such as ls, clear, mount, etc.
# HISTTIMEFORMAT — Shows timestamp in history. (BASH ONLY) export HISTTIMEFORMAT='%F %T '

#######################################
# Displays COMMAND HISTORY TIMESTAMP
# (ZSH) because above variable is bash only
#######################################
HIST_STAMPS="yyyy-mm-dd"
#alias history='history -i' # alternatively -E 


## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data



## History wrapper function
function omz_history {
  local clear list
  zparseopts -E c=clear l=list

  if [[ -n "$clear" ]]; then
    # if -c provided, clobber the history file
    echo -n >| "$HISTFILE"
    fc -p "$HISTFILE"
    echo >&2 History file deleted.
  elif [[ -n "$list" ]]; then
    # if -l provided, run as if calling `fc' directly
    builtin fc "$@"
  else
    # unless a number is provided, show all history events (starting from 1)
    [[ ${@[-1]-} = *[0-9]* ]] && builtin fc -l "$@" || builtin fc -l "$@" 1
  fi
}

# Timestamp format
case ${HIST_STAMPS-} in
  "mm/dd/yyyy") alias history='omz_history -f' ;;
  "dd.mm.yyyy") alias history='omz_history -E' ;;
  "yyyy-mm-dd") alias history='omz_history -i' ;;
  "") alias history='omz_history' ;;
  *) alias history="omz_history -t '$HIST_STAMPS'" ;;
esac




# h - prints your history
alias h='history'
# hs [searchterm] - searches your history with grep
alias hs='history | grep'
# hsi [serachterm] - same as above but case insensitive.
alias hsi='history | grep -i'


# Show last N commmands in history
alias h10='history -10'
alias h20='history -20'
alias h30='history -30'
