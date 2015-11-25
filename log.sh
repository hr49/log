#!/bin/bash
set -eo pipefail
unalias -a
log_directory_directory="$HOME/log/$1"
if [[ -d $log_directory_directory ]]; then
        log_index=$(ls "$log_directory_directory" | sed 's/^[1-9] \([1-9][0-9]\{0,8\}\)\( \S\+\)\+$/\1/' | sort -n | tail -n1)
fi
((++log_index))
log_directory="$log_directory_directory/${#log_index} $log_index ${*:2}"
error_fifo_directory="$(mktemp -d)"
trap "rm -fr $error_fifo_directory" EXIT
error_fifo=$error_fifo_directory/error
mkfifo $error_fifo
exec 3<> $error_fifo
"$@" 2>&3 | tee /dev/tty | install -D /dev/stdin "$log_directory/1" | 3>&1 tee /dev/tty | install -D /dev/stdin "$log_directory/2"
