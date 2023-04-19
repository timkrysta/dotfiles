#######################################
# WI-FI network stuff
#######################################
#
# https://www.techrepublic.com/article/pro-tip-manage-wi-fi-with-terminal-commands-on-os-x/

# Try below to determine $NET_INTERFACE
# which interface (en0, en1, etc.) is your Airport adapter.
#
# ifconfig # List all network interfaces and their status.
# or
# networksetup -listallhardwareports # Network connections list

export NET_INTERFACE="en0"

# You can issue the below commands without sudo but you will get a popup 
# prompting youfor a password for each networksetup invocation
function wifitoggle widitoggle wifi_toggle widi_toggle wifi {
  local wifi_status
  wifi_status="$(networksetup -getairportpower $NET_INTERFACE)"
  if [[ $wifi_status == *"On"* ]]; then
    networksetup -setairportpower $NET_INTERFACE off
  else
    networksetup -setairportpower $NET_INTERFACE on
  fi
}
function wifion widion wifi_on widi_on wifion widion wifistart {
  networksetup -setairportpower $NET_INTERFACE on
}
function wifioff widioff wifi_off widi_off wifioff widioff wifistop {
  networksetup -setairportpower $NET_INTERFACE off
}

# List available Wi-Fi networks
function wifils widils wifi_ls widi_ls wifi_list widi_list {
  airport -s
}

# Join Wi-Fi network
function join_wifi wifi_connect {
  if [ $# -eq 2 ]; then
    networksetup -setairportnetwork $NET_INTERFACE $1 $2
  else
    echo "2 arguments are required: SSID (wifi name) and PASSWORD"
    return 1
  fi
}