#!/bin/bash

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -eo pipefail
unalias -a

_get_home () {
    # cf. <https://superuser.com/a/484330>
    getent passwd "$1"|cut -d: -f6
}

[[ $HOME == $(_get_home $EUID) ]] || {
echo "$0: You must execute this program on a login shell"
exit 1
} >&2

_tty_logger_directory="$HOME/var/log"
_default_tty_log_filename="$_tty_logger_directory/tty.log"

_generate_tty_logs_filename_version () {
    for _string in $_tty_logger_directory/*
    do
        if [[ ${_string#$_default_tty_log_filename} =~ ^\.([1-9][0-9]*)$ ]]
        then echo "${BASH_REMATCH[1]}"
        fi
    done
}
