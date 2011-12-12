# b, a simple bookmarking system

## Usage:
      b [bookmark] [directory]

## Options:
      -h, --help            Show this help screen

## Notes:
If `b` is run with no arguments, it will list all of the bookmarks.  If it is
given a bookmark, it will attempt to `cd` into that bookmark.  If it is given a
bookmark and directory, it will create that bookmark.

## Examples:
    $ b home /home/user
      Added home,/home/user to bookmark list    
    $ b
      List of bookmarks:
      home,/home/user
      ...
    $ b home
      will cd to the home directory
    $ echo `b home`
      /home/user
