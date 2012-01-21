# b, a simple bookmarking system

## Usage:
      b [bookmark] [directory]
      b [bookmark] [file]

## Options:
      -h, --help            Show this help screen

## Notes:
If `b` is run with no arguments, it will list all of the bookmarks.
If it is given a bookmark that is a directory, it will attempt to cd into that bookmark.
If it is given a bookmark that is a file, it will attempt to open that bookmark.
If it is given a bookmark and directory or file, it will create that bookmark.

## Examples:
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
    $ echo `b home`
      /home/user
    $ b p
      will open ~/.profile
      If your computer is a Mac, it will use the `open` command, otherwise it
      will use the `$EDITOR`.
