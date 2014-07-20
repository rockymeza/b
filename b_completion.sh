#!/usr/bin/env bash
if [[ -n ${ZSH_VERSION-} ]]; then
	autoload -U +X bashcompinit && bashcompinit
fi

_b()
{
	COMPREPLY=();
	cur="${COMP_WORDS[COMP_CWORD]}";
	if [ $COMP_CWORD -eq 1 ] ; then
		opts=$(cut -f1 -d, ~/.b_bookmarks);
		COMPREPLY=( $(compgen -W "$opts" -- $cur) );
	fi
        # include directories too, so you can replace cd with b
	COMPREPLY=( ${COMPREPLY[@]} $(compgen -A directory "$cur") );
}
complete -F _b b
