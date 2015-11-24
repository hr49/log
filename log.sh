#!/bin/bash
unalias -a
directory="$HOME/log/$1"
test -d "$directory" && { index="$(\ls "$directory" | grep '^[1-9] [1-9][0-9]\{0,8\} \S.*' | sed 's/^[1-9] \([1-9][0-9]\{0,8\}\) \S.*/\1/g' | sort -n | tail -n1; exit "${PIPESTATUS[0]}")" || exit 1; }
let index+=1
"$@" | install -D /dev/stdin "$directory/${#index} $index ${*:2}" || exit 1
