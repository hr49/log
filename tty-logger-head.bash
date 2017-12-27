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

_usage="usage: $0 VERSION"

[[ -n $1 ]] || {
echo -e "$_usage\n"\
"$0: error: the following arguments are required: VERSION"
exit 1
} >&2

_version="$(($1))"

(( $_version >= 0 )) || {
echo -e "$_usage\n"\
"$0: error: argument VERSION: '$_version' is not a non-negative integer"
exit 1
} >&2

if (( $_version == 0 ))
then exec 3< "$_default_tty_log_filename"
else exec 3< "$_default_tty_log_filename.$_version"
fi

sed -n '2p' <&3
exec 3>&-
