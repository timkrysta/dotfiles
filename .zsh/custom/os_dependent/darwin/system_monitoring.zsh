#######################################
# Display syslog from specified time.
# Arguments:
#   Time, example 24h, 10m
# Outputs:
#   Writes syslog to stdout
# Returns:
#   0 if thing was deleted, non-zero on error.
#######################################
function syslog_() {
  if [[ $# -gt 1 ]]; then
    echo "To many argumets were passed try:"
    echo "${funcstack} 24h or ${funcstack} 10m"
    return 1
  else
    syslog -k Time ge -"$@"
  fi

  echo ""
  if [[ $# -eq 0 ]]; then
    echo "No arguments were passed so all syslog was shown"
  fi
  return 0
}
# alias syslog_24='syslog -k Time ge -24h'


#######################################
# MACOS Monitoring system stats
#######################################

alias df="df -ha"
alias du="du -ach | sort -h"

# Search our process for an argument we’ll pass:
alias {psg,pss}="/bin/ps aux | grep -v grep | grep -i -e VSZ -e"
# a = show processes for all users
# u = display the process’s user/owner
# x = also show processes not attached to a terminal
#
# Example: psg bash, psg mysql