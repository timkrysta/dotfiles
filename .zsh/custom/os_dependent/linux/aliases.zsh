alias {show_ports,showports,show_listening_ports}='netstat -tuplen'

alias root="sudo su -"
# That way I can root to switch to root or even root someuser to switch to someuser.

function ss() {
  # the standard 'ss' output is horrible. we can
  # make it more readable by piping to `column`
  $(which ss) $1 | column -t
}

# To list all processes in the system:
alias process="ps -aux"
# To check the status of any system service:
alias sstatus="sudo systemctl status"
# To restart any system service:
alias srestart="sudo systemctl restart"

# To display the current system Linux distro
# Check release (what OS is installed)
function os get_os getos check_release() {
  if [ -f /etc/redhat-release ]; then
      RELEASE="centos"
  elif grep -Eqi "debian" /etc/issue; then
      RELEASE="debian"
  elif grep -Eqi "ubuntu" /etc/issue; then
      RELEASE="ubuntu"
  elif grep -Eqi "centos|red hat|redhat" /etc/issue; then
      RELEASE="centos"
  elif grep -Eqi "debian" /proc/version; then
      RELEASE="debian"
  elif grep -Eqi "ubuntu" /proc/version; then
      RELEASE="ubuntu"
  elif grep -Eqi "centos|red hat|redhat" /proc/version; then
      RELEASE="centos"
  fi
  echo "$RELEASE"
}