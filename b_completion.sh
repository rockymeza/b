_b()
{
	COMPREPLY=();
	cur="${COMP_WORDS[COMP_CWORD]}";
	if [ $COMP_CWORD -eq 1 ] ; then
		opts=$(cut -f1 -d, ~/.b_bookmarks);
		COMPREPLY=( $(compgen -W "$opts" -- $cur) );
	fi
        # include directories too, so you can replace cd with b
	COMPREPLY=($(echo $COMPREPLY $(compgen -A directory "$cur")));
}
complete -F _b b
