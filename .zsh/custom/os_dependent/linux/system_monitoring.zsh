#######################################
# Monitoring system stats (CPU GPU RAM)
# this is identical as in server.zsh
#######################################

# Get top process eating memory (RAM)
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
 
# get top process eating CPU
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
 
# Get server CPU info
alias cpuinfo='lscpu'
 
# Older system use /proc/cpuinfo
# alias cpuinfo='less /proc/cpuinfo'

# Interactive process viewer
alias top="htop"

#######################################
# Disk Usage
#######################################

##### Basic commands
#
# df - command (short for disk free)
# displays information related to file systems about total space and available space. 
# If no file name is given, it displays the space 
# available on all currently mounted file systems.
#
# list disk usage in human-readable units including
# filesystem type, and print a total at the bottom:
alias df="df -Tha --total"
# sort du output from the smallest
alias du="du -ach | sort -h"


##### Third party enhanced commands
#
alias df="pydf" # install pydf
alias du="ncdu" # install ncdu


# Make free output more human friendly
alias {free,meminfo}='free -mt'


# ps - process
# Set a default output for our listing process table.
alias ps="ps auxf"

# Search our process for an argument we’ll pass:
alias {psg,pss}="ps aux | grep -v grep | grep -i -e VSZ -e"
# Example: psg bash, psg mysql

function memtotal ramtotal() {

  # get available physical ram
  availMemMb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
  #debug: echo $availMemMb
  echo "-> Available Physical RAM (not formatted) on machine: ${availMemMb}"
  
  mb=$(awk "BEGIN {print ${availMemMb}/1024}")
  echo "-> Available Physical RAM (in Megabytes): ${mb} Mb"

  # convert from kb to mb to gb
  gb=$(awk "BEGIN {print ${availMemMb}/1024/1204}")
  #debug: echo $gb
  
  # round the number to nearest gb
  gb=$(echo ${gb} | awk '{print ($0-int($0)<0.499)?int($0):int($0)+1}')
  #debug: echo $gb

  echo "-> Available Physical RAM (rounded): ${gb} Gb"
}