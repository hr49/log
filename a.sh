#!/bin/bash
while IFS= read -r a; do stdbuf -o0 -e0 printf "%s $HOSTNAME $1: %s\n" "$(stdbuf -o0 -e0 date '+%b %e %T')" "$a"; done
