#!/bin/bash
set -eo pipefail
unalias -a
install -d "$HOME/logger.sh"
{
if [[ -e $HOME/logger.sh/syslog ]]
then exec 3>"$HOME/logger.sh/syslog.$(($(ls -1 "$HOME/logger.sh"|grep '^syslog\.[1-9][0-9]*$'|sed 's/^syslog\.\([1-9][0-9]*\)$/\1/'|sort -n|tail -n1)+1))"
else exec 3>"$HOME/logger.sh/syslog"
fi
} 4>"$HOME/logger.sh/lock"
format(){
while IFS= read -r x; do stdbuf -o0 printf "%s $HOSTNAME $1: %s\n" "$(stdbuf -o0 date '+%b %e %T')" "$x"; done
}
echo "$@"|format 0 >&3
{
{
{
{
{
{
"$@" 4>&-|tee /dev/stderr 2>&4 4>&-
} 2>&1 >&6|tee /dev/stderr 2>&5 4>&- 5>&- 6>&-
}>&7
} 6>&1|format 1 >&3 4>&- 5>&- 6>&- 7>&-
} 7>&1|format 2 >&3 4>&- 5>&- 6>&- 7>&-
} 4>&1
} 5>&2
