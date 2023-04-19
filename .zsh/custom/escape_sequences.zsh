#######################################
# ESCAPE SEQUENCES
# ANSI Escape Codes
# https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
#######################################

# Basic escape sequance (Linux TERM) is: 
# printf '\e[?x;y;zc'
# simple form
# printf '\e[?xc'
# replace x, y, z

# x, y, z represents bytes

# Basic escape sequance (xterm TERM) is: 
# printf '\e[x:y:z q'
# simple form
# printf '\e[x q'
# replace x, y, z


#######################################
# Changing terminal cursor apperance 
#######################################

alias cursor_thin="printf '\e[5 q'"
alias cursor_underscore="printf '\e[4 q'"
alias cursor_block="printf '\e[2 q'"

# printf '\e[x q'
# Where x takes a value from 1 to 6 (from xterm manual):
# 
# 0 -> blinking block.
# 1 -> blinking block (default).
# 2 -> steady block.
# 3 -> blinking underline.
# 4 -> steady underline.
# 5 -> blinking bar (xterm).
# 6 -> steady bar (xterm).