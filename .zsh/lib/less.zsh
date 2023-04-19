# You need to install highlight http://www.andre-simon.de

#######################################
# Enable colorized output of less command.
# Dependencies:
#   highlight or pygmentize
# Returns:
#   0 if thing was deleted, non-zero on error.
#######################################
function less_highlighter() {
  source_code_highlighter=highlight # You can also use for example pygmentize instead of highlight
  if command -v $source_code_highlighter &> /dev/null; then 

    # $source_code_highlighter was found
      
    # from man less:
        # -r or --raw-control-chars
            # Causes "raw" control characters to be displayed. (...)
        # -R or --RAW-CONTROL-CHARS
            # Like -r, but only ANSI "color" escape sequences are output in "raw" form. (...)
    #export LESS='-R'
    export LESS="-RCQix4" # this variable adds flags to less while run
    
    export LESSOPEN='|highlight -O xterm256 %s' # LESSOPEN is a Unix less pager preprocessor

    # ALTERNATIVE
        # export LESSOPEN='|pygmentize %s'
        # pygmentize -g /file/to/show | less -r
  else 
    echo "Command: ${source_code_highlighter} could not be found please install it first"
  fi
}

less_highlighter