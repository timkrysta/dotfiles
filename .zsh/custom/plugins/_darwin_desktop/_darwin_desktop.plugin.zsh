fname='_darwin_desktop'
echo "[$(date +'%H:%M:%S')]: ${fname}"

source_whole_dir "${ZSH_CUSTOM}/plugins/${fname}/src"

[[ -z "$OS_DEPENDENT" ]] && export OS_DEPENDENT="$ZSH_CUSTOM/os_dependent"
source_whole_dir "${OS_DEPENDENT}/desktop"