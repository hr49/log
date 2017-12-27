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

. tty-logger-init.bash

_default_tty_log_exists="$({
[[ -e $_default_tty_log_filename ]]
echo "$?"
})"

_format () {
    echo -e "\E[33mlog $1\E[m\n"\
"Date: $(date -d "$(head -n1 "$1")" '+%a %b %d %H:%M:%S %Y %z')\n"\
"\n"\
"    $(sed -n '2p' "$1")"
}

{
for _tty_log_filename_version in $(
    _generate_tty_logs_filename_version|sort -nr)
do
    _format "$_default_tty_log_filename.$_tty_log_filename_version"
    [[ ! $_default_tty_log_exists ]] || echo
done

[[ ! $_default_tty_log_exists ]] || _format "$_default_tty_log_filename"
}|less -FRX
