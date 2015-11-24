#!/bin/bash
set -eo pipefail
unalias -a
d="$HOME/log/$1"
if test -d "$d"; then
        index=$(ls "$d" | sed 's/^[1-9] \([1-9][0-9]\{0,8\}\)\( \S\+\)\+$/\1/' | sort -n | tail -n1)
fi
((++index))
d="$d/${#index} $index ${*:2}"
tmp_d=$(mktemp -d)
fifo=$tmp_d/3
mkfifo $fifo
trap "rm -rf $tmp_d" 0
exec 3<> $fifo
trap "exec 3>&-" 0
"$@" 2>&3 | tee /dev/tty | install -D /dev/stdin "$d/1" | 3>&1 tee /dev/tty | install -D /dev/stdin "$d/2"
