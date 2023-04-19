echo "[$(date +'%H:%M:%S')]: .zlogout"

# Clear the screen
clear

# Clear mysql history for security reasons
mysql_history="$HOME/.mysql_history"
# -s will give TRUE if file exists AND has a size > 0.
[ -s "${mysql_history}" ] && cat /dev/null > "${mysql_history}"

# Clear shell command history for security reasons
# https://unix.stackexchange.com/questions/544373/how-to-clear-history-in-zsh
#
#[ -s "${HISTFILE}" ] && cat /dev/null > "${HISTFILE}"


# Backup files to NAS (network attached server) by running the backup script
# ~/bin/backup.sh
if command_exists backup; then
  backup
else
  echo "Unable to make backup. Script ... not found"
fi


# SERVER
#
# When leaving the console clear the screen to increase privacy
#if [ "$SHLVL" = 1 ]; then
#  [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
#fi
#
# $SHLVL is a environment variable which came from "SHell LeVeL" and 
# lets you track how many subshells deep your current shell is. 
# In your top-level shell, the value of $SHLVL is 1. In the first subshell, 
# it's 2; in a sub-subshell, it's 3; and so on. 
# So SHLVL indicates how many shells deep the user is.
