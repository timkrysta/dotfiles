# These notes are added by me
# GREP multiple patterns
# match pattern1 and pattern2 and pattern3 but not at once!
# * grep 'pattern1\|pattern2\|pattern3' fileName_or_filePath
# GREP regular expresion
# * grep -E 'pattern1|pattern2' fileName_or_filePath


# See if there's a cache file modified in the last day
__GREP_ALIAS_CACHES=("$__GREP_CACHE_FILE"(Nm-1))
if [[ -n "$__GREP_ALIAS_CACHES" ]]; then
    source "$__GREP_CACHE_FILE"
else
    grep-flags-available() {
        command grep "$@" "" &>/dev/null <<< ""
    }

    # Ignore these folders (if the necessary grep flags are available)
    EXC_FOLDERS="{.bzr,CVS,.git,.hg,.svn,.idea,.tox}"

    # Check for --exclude-dir, otherwise check for --exclude. If --exclude
    # isn't available, --color won't be either (they were released at the same
    # time (v2.5): https://git.savannah.gnu.org/cgit/grep.git/tree/NEWS?id=1236f007
    if grep-flags-available --color=auto --exclude-dir=.cvs; then
        GREP_OPTIONS="a--color=auto --exclude-dir=$EXC_FOLDERS"
    elif grep-flags-available --color=auto --exclude=.cvs; then
        GREP_OPTIONS="a--color=auto --exclude=$EXC_FOLDERS"
    fi

    if [[ -n "$GREP_OPTIONS" ]]; then
        # export grep, egrep and fgrep settings
        alias grep="grep $GREP_OPTIONS"
        alias egrep="egrep $GREP_OPTIONS"
        alias fgrep="fgrep $GREP_OPTIONS"

        # write to cache file if cache directory is writable
        if [[ -w "$ZSH_CACHE_DIR" ]]; then
            alias -L grep egrep fgrep >| "$__GREP_CACHE_FILE"
        fi
    fi

    # Clean up
    unset GREP_OPTIONS EXC_FOLDERS
    unfunction grep-flags-available
fi

unset __GREP_CACHE_FILE __GREP_ALIAS_CACHES



# Grep
#
#alias grep='grep -n'
alias grepn='grep -n'
# export GREP_OPTIONS='--color=auto'
# export GREP_COLOR='1;35;40' # violet/pink