fname='_linux_desktop'
echo "[$(date +'%H:%M:%S')]: ${fname}"

source_whole_dir "${ZSH_CUSTOM}/plugins/${fname}/src"

[[ -z "$OS_DEPENDENT" ]] && export OS_DEPENDENT="$ZSH_CUSTOM/os_dependent"
source_whole_dir "${OS_DEPENDENT}/desktop"

#######################################
# Connect bluetooth device via terminal
#######################################
#
# https://unix.stackexchange.com/questions/96693/connect-to-a-bluetooth-device-via-terminal
# or bluetoothctl
# or hcitool

# Get GPU ram on desktop / laptop##
alias gpumeminfo='grep -i --color memory /var/log/Xorg.0.log'