# Defines environment variable required to run this utility.
#
# #printf "Usage: From the top directory of this utility, \
# #        source this file as follows:\n\n. ./setenv.sh\n\n"
#
# Before running executable shell scripts of this utility,
#  this file must be source-d in current shell as follows:
#
# . ./setenv.sh
#
# Alternatively, if can be pasted to current shell.
#   
# ### Long term recommendation for using this utility ###
#
#  Add to your shell init file the lines below starting with 'export',
#    and replace the string "$(pwd)" with the full path of the directory
#    where this project was checked out, for example with
#    "~/software/emacs-org-asciimath2tex".
#

export EMACS_ORG_ASCIIMATH2TEX
EMACS_ORG_ASCIIMATH2TEX="$(pwd)"
PATH="$PATH:$EMACS_ORG_ASCIIMATH2TEX"
