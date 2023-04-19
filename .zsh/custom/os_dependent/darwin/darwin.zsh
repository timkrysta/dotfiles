### Wrapper function for macos 'open' command
#
# before reading function get the 'open' command path not to make loop of conflicting names
open_command_path=$(which open) 
# If no args are passed run: open .
function open() {
  if [[ $# -eq 0 ]]; then
    "$open_command_path" .
  else
    "$open_command_path" "$@"
  fi
}

function applescript osa() {
  osascript -e "$@"
}
# alias osascripti='osascript -i' # interactive mode

# They're both interoperable: 
#
# you can call a shell command from AppleScript with do shell script "command here" 
# and 
# you can call AppleScript code from the shell with osascript -e "AppleScript"
#
# Or you can invode apple script from terminal in below examples:
# * echo 'set volume without output muted' | osascript
# Or
# * osascript <<EOF set volume without output muted EOF

# Turn off Wi-Fi and Bluetooth (leave for charging)
function charge() {
  echo "Bye!"
  bt_off
  wifi_off
}

# Open application
function opena {
  open -a "$@"
}
# Kill application
function killa closea quita {
  if [ -z "$1" ]; then
    echo "You need to pass App Name you want to close"
  else
    # This allows the program to make sure files are saved and everything
    # is in order before the process ends.
    osascript -e "tell application '$@' to quit"

    # Kill simply aborts the running process, regardless of what’s happening, 
    # which could result in data loss and other instabilities
    # pkill -x "$@"
  fi
}


alias text_edit='open -a TextEdit'
alias preview='open -a Preview'
alias open_music='open -a Music'
alias open_virtualbox='open -a VirtualBox'
alias amonitor="open -a 'Activity Monitor'"
alias {finder,Finder}="open -a Finder"
alias {afinder,aFinder}="open -a Finder && open -a Finder"

# Recursively delete `.DS_Store` files
alias {rmds,rm_ds_store,cleanup}='sudo find / -type f -name "*.DS_Store" -ls -delete' # 2> /dev/null

function lookup() { # For MacOs built-in dictionary
  open dict://$1
}

# System Preferences
#
# Open System Preferences main
alias {syspref,pref}="open x-apple.systempreferences:"
# Security preferences
alias secpref="open x-apple.systempreferences:com.apple.preference.security"
# Turn display off here - screen time
alias batterypref="open x-apple.systempreferences:com.apple.preference.battery"
alias mute="osascript -e 'set volume with output muted'"
alias unmute="osascript -e 'set volume without output muted'"

function bt_explorer btexplorer() 
{
  open -a "Bluetooth Explorer" && {
    echo "Bluetooth Explorer is running, click now:"
    echo "Command + Shift + A                   to open: Tools -> Audio Options"
    echo "Command + Shift + Option(alt) + A     to open: Tools -> Audio Graphs"
  } || {
    echo "Unable to open 'Bluetooth Explorer' app"
  }
}

# Open QuickLook from terminal
# -p displays the Quick Look generated previews for the specified files.
alias {ql,quicklook}="qlmanage -p"

# cd and open finder there
function cdf() { # short for `cdfinder`
	cd "$@" && open .
}
alias open.="open ."

# `o` with no arguments opens the current directory, otherwise opens the given
# location
function o() {
	if [ $# -eq 0 ]; then
		open .;
	else
		open "$@";
	fi;
}


# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# Canonical hex dump; some systems have this symlinked
command -v hd > /dev/null || alias hd="hexdump -C"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Merge PDF files, preserving hyperlinks
# Usage: `mergepdf input{1,2,3}.pdf`
alias mergepdf='gs -q -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -sOutputFile=_merged.pdf'

# Disable Spotlight
#alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
#alias spoton="sudo mdutil -a -i on"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "${method}"="lwp-request -m '${method}'"
done


# Stuff I never really use but cannot delete either because of http://xkcd.com/530/ ;))
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume output volume 100'"

# Lock the screen (when going AFK)
alias {afk,lock,lockscreen,lock_screen}="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down, control down}'"

# Get macOS Software Updates, and update installed Homebrew, npm, and their installed packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g;'

# Hide/show all desktop icons (useful when presenting)
#
# Hide Desktop Icons Completely
# Hiding dekstop incons makes a minimalist onscreen experience. 
# The files are still accessible through the Finder and Terminal in the Desktop folder, 
# you just won’t see them covering your wallpaper all the time.
alias {hide_desktop,hidedesktop}="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
# Shows back Desktop icons again (Deletes above entry if exists)
alias {show_desktop,showdesktop}="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# These are functions corresponding to .macos
function enable_key_repeat enable_key_hold() {
  # Disable press-and-hold for keys in favor of key repeat
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false # Default: not exist

  # Set a blazingly fast keyboard repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 1 # Default: 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 10 # Default: 35
}
function disable_key_repeat disable_key_hold() {
  # Disable press-and-hold for keys in favor of key repeat
  defaults delete NSGlobalDomain ApplePressAndHoldEnabled # Default: not exist

  # Set a blazingly fast keyboard repeat rate
  defaults write NSGlobalDomain KeyRepeat -int 2 # Default: 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 35 # Default: 35
}

# To revert below setting run this function:
#
# Remove the animation when hiding/showing the Dock
#defaults write com.apple.dock autohide-time-modifier -float 0
function bring_back_dock_animation() {
  defaults delete com.apple.dock autohide-time-modifier && killall Dock
}
