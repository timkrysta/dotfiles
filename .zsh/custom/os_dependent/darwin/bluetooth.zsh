#######################################
# Connect bluetooth device via terminal
#######################################
#
# brew install blueutil
alias bt='blueutil'

# Bluetooth on
alias {bt_on,bton}='blueutil --power 1'

# Bluetooth off
alias {bt_off,btoff}='blueutil --power 0'

# Get details about Bluetooth - devices paired, with their names, MAC address.
alias bt_details='system_profiler SPBluetoothDataType'

# Connect to bluetooth device via MAC Address 
# 
# brew install bluetoothconnector
# https://github.com/lapfelix/BluetoothConnector

# To toggle the connection (connect/disconnect) and be notified about it
function bt_toggle {
  BluetoothConnector "$@" --notify
}

# To connect and be notified about it
function bt_connect bt_conn {
  BluetoothConnector --connect "$@" --notify
  # BluetoothConnector -c "$@" --notify
}

# To disconnect
function bt_disconnect {
  BluetoothConnector --disconnect "$@"
  # BluetoothConnector -d "$@"
}

#######################################
# Bluetooth status
# Returns:
#   0 if bt is on
#   1 if bt is off
#######################################
function bt_status() {
  local result
  result=$(blueutil -p)
  if [ $result = "1" ]; then 
    # Bt is on
    return 0
  elif [ $result = "0" ]; then 
    # Bt is off
    return 1
  else
    echo "else"
    return 1
  fi
}