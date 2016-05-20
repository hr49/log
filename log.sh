#!/bin/bash
set -eo pipefail
unalias -a
if [[ -z $1 ]]; then
        exit 1
fi
a="$HOME/log.sh/$1"
if [[ -d $a ]]; then
        b="$(ls -1 "$a" | sed 's/^\([1-9][0-9]*\)\( .*\)\?/\1/' | sort -n | tail -n1)"
fi
((++b))
c="$a/$b"
if [[ ! -z ${@:2} ]]; then
        c="$c ${@:2}"
fi
echo -n | install -D /dev/stdin "$c"
{
        {
                {
                        {
                                {
                                        stdbuf -o0 -e0 "$@" 3>&- | stdbuf -i0 -o0 -e0 tee /dev/stderr 2>&3 3>&-
                                } 2>&1 >&4 4>&- | stdbuf -i0 -o0 -e0 tee /dev/stderr 2>&3 3>&- 4>&-
                        } >&5 5>&-
                } 4>&1 | ./a.sh stdout >> "$c" 2>&3 3>&- 4>&- 5>&-
        } 5>&1 | ./a.sh stderr >> "$c" 2>&3 3>&- 4>&- 5>&-
} 3>&2
