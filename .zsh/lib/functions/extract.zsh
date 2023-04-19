##
# Extract many files with one command
#
# Can be ran as a standalone executable shell script



# Who has time in the world to figure out 
# the right extract commands for all the possible formats. 

function extract_original() {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1    ;;
      *.tar.gz)    tar xvzf $1    ;;
      *.tar.xz)    tar Jxvf $1    ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       rar x $1       ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xvf $1     ;;
      *.tbz2)      tar xvjf $1    ;;
      *.tgz)       tar xvzf $1    ;;
      *.zip)       unzip -d `echo $1 | sed 's/\(.*\)\.zip/\1/'` $1;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)           echo "[extract]: don't know how to extract '$1'" ;;
    esac
  else
    echo "[extract]: '$1' file does not exist"
    return 1
  fi
}

# Allows to do extract on more than 1 file
function extract() {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
  else
    for n in $@
    do
      if [ -f "$n" ] ; then
        case "${n%,}" in
          *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                      tar xvf "$n"       ;;
          *.lzma)     unlzma ./"$n"      ;;
          *.bz2)      bunzip2 ./"$n"     ;;
          *.rar)      unrar x -ad ./"$n" ;;
          *.gz)       gunzip ./"$n"      ;;
          *.zip)      unzip ./"$n"       ;;
          *.z)        uncompress ./"$n"  ;;
          *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                      7z x ./"$n"        ;;
          *.xz)       unxz ./"$n"        ;;
          *.exe)      cabextract ./"$n"  ;;
          *)          echo "[extract]: don't know how to extract '$n'"
                      return 1           ;;
        esac
      else
        echo "[extract]: '$n' - file does not exist"
        return 1
      fi
    done
  fi
}


#extract "$1"
#extract_v2 "$@"