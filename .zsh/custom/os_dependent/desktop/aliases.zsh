
function howto wikihowto() {
  if [[ $# -eq 0 ]]; then
    open_command https://www.wikihow.com
  else
    web_search google "$@ site:wikihow.com" 
  fi
}

alias diffchecker="open_command https://www.diffchecker.com"
alias {googledrive,gdriveweb,gdrivegui}="open_command https://drive.google.com/drive/u/0/my-drive"
alias {translate,transweb,webtrans,gtrans}='open_command https://translate.google.pl'
alias regex="open_command https://regexr.com"
alias {asciitab,table_generator}="open_command https://ozh.github.io/ascii-tables/"
alias {advanced_search,advanced,advs}="open_command https://www.google.com/advanced_search"
alias {gitcheatsheet,gcheatsheet}="open_command https://gist.github.com/davfre/8313299"

alias code.="code ."
alias {g,gogle}='google'
alias yt='youtube'
alias trnas='trans'
alias {stack,overflow}='stackoverflow'

alias 2048='bash <(curl -s https://raw.githubusercontent.com/mydzor/bash2048/master/bash2048.sh)'
alias pomodoro='pydoro'

# Downloads a .mp3 file
# Extract audio from video
# if you ever wish to uninstall youtube-dl run: brew remove ffmpeg && brew remove youtube-dl
function dlmp3 ytgetaudio ytgetbestaudio() {
  #sudo youtube-dl --extract-audio --audio-format mp3 "$1"

  # From: https://askubuntu.com/questions/634584/how-to-download-youtube-videos-as-a-best-quality-audio-mp3-using-youtube-dl
  # To get list of all yt video/audio formats
  sudo youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 "$@"
}

# function dlmp4 ytgetvideo() {
#   youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' "$1"
# }

function dns_check dnscheck checkdns dns dnslookup() {
  local HOST \
        TYPE      
  HOST="$1"
  TYPE="$2"

  #HOST="x._domainkey.justeuro.eu"
  #TYPE="TXT" # A | CNAME
  open_command "https://www.dnswatch.info/dns/dnslookup?la=en&host=${HOST}&type=${TYPE}&submit=Resolve"
}