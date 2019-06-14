#!/bin/bash
#######################################################
#  UNIX TREE                                          #
#                                                     #
#  Displays Structure of Directory Hierarchy          #
#  -------------------------------------------------  #
#  This tiny script uses "ls", "grep", and "sed"      #
#  in a single command to show the nesting of         #
#  sub-directories.  The setup command for PATH       #
#  works with the Bash shell (the Mac OS X default).  #
#                                                     #
#  Setup:                                             #
#     $ cd ~/apps/tree                                #
#     $ chmod u+x tree.sh                             #
#     $ ln -s ~/apps/tree/tree.sh ~/bin/tree          #
#     $ echo "PATH=~/bin:\${PATH}" >> ~/.profile      #
#                                                     #
#  Usage:                                             #
#     $ tree [directory]                              #
#                                                     #
#  Examples:                                          #
#     $ tree                                          #
#     $ tree /etc/opt                                 #
#     $ tree ..                                       #
#                                                     #
#######################################################

if [ "$1" != "" ]; then
  #if parameter exists, use as base folder
  cd "$1"
fi

pwd

# 1st sed: remove colons
# 2nd sed: replace higher level folder names with dashes
# 3rd sed: indent graph three spaces
# 4th sed: replace first dash with a vertical bar
find ./ -type d ! -path "./.*" | grep -vP '^(\s+)?\.\/$' \
   | sed -e 's/\/$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'

# check if no folders
if [ "$(find ./ -type d ! -path "./.*" | wc -l)" -le 1 ]; then
  echo "   -> no sub-directories"
fi

exit
