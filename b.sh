#!/usr/bin/env bash
# b, a simple bookmarking system
# by Rocky Meza

BOOKMARKS_FILE=$HOME/.b_bookmarks
read -r -d '' USAGE <<HEREDOC
b, a simple bookmarking system

Usage:
      b [bookmark] [directory]
      b [bookmark] [file]

Options:
      -h, --help            Show this help screen

Notes:
      If b is run with no arguments, it will list all of the bookmarks.
      If it is given a bookmark that is a directory, it will attempt to cd into that bookmark.
      If it is given a bookmark that is a file, it will attempt to open that bookmark.
      If it is given a bookmark and directory or file, it will create that bookmark.

Examples:
    $ b home /home/user
      Added home,/home/user to bookmark list
    $ b p /home/user/.profile
      Added p,/home/user/.profile to bookmark list
    $ b
      List of bookmarks:
      home,/home/user
      p,/home/user/.profile
      ...
    $ b home
      will cd to the home directory
    $ echo \`b home\`
      /home/user
    $ b p
      will open ~/.profile
      If your computer is a Mac, it will use the \`open\` command, otherwise it
      will use the \`\$EDITOR\`.
HEREDOC

## private

# Creates the bookmark database if it doesn't exist.
__b_init()
{
  if [[ ! -f "$BOOKMARKS_FILE" ]]; then
    touch $BOOKMARKS_FILE
  fi
}

# List all of the bookmarks in the database.
__b_list()
{
  echo "List of bookmarks:"
  # sorry
  cat "$BOOKMARKS_FILE"
}

# Will add a bookmark to the database if it doesn't already exist.  `add` will
# also expand the bookmark.  You can use relative paths or things like `.`,
# `..`, and `~`.
__b_add()
{
  __b_find_mark $1
  if [[ -n "$mark" ]]; then
    echo "That bookmark is already in use."
  else
    dir=`readlink -f $2`

    echo "$1,$dir" >> $BOOKMARKS_FILE
    echo "Added $1,$dir to bookmarks list"
  fi
}

# Will `cd` to the bookmarked directory.  If no bookmark matches the one
# specified, it will print an error.
open_command="$EDITOR"
if [[ `uname` = "Darwin" ]]; then
  open_command=open
fi

__b_cd()
{
  __b_find_mark "$1"
  if [[ -n "$mark" ]]; then
    dir=$(echo $mark | sed 's/^[^,]*,\(.*\)/\1/')
    # if not a tty, print to stdout
    if [ ! -t 1 ] ; then
      echo -n "$dir"
    elif [[ -d $dir ]]; then
      cd $dir
      if [[ -f "$dir/.b_hook" ]]; then
        source "$dir/.b_hook"
      fi
    else
      $open_command "$dir"
    fi
  else
    echo "That bookmark does not exist." >&2
  fi
}

__b_find_mark()
{
  mark=$(grep "^$1," < $BOOKMARKS_FILE)
}

## public

# This is the entry point.  It parses the arguments and then delegates to other
# functions.
b()
{
  if [[ "$#" -eq 1 ]]; then
    if [[ $1 == "-h" ]] || [[ $1 == "--help" ]]; then
      echo "$USAGE"
    else
      __b_cd $1
    fi
  elif [[ "$#" -eq 2 ]]; then
    __b_add $1 $2
  else
    __b_list
  fi
}

# main
__b_init
