#!/bin/bash

# Copyright (C) 2018 Matthew Marting
#
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
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

if [[ -z ${LIBTLOGGER_SH+x} ]]; then
  readonly LIBTLOGGER_SH=

  source libversion.sh

  readonly LOG_PATH_DIRNAME="$HOME"'/var/log'
  readonly LOG_BASENAME_VERSION_HEAD='tty'
  readonly LOG_PATH_VERSION_HEAD="$(version::path_version_head \
        "$LOG_PATH_DIRNAME" \
        "$LOG_BASENAME_VERSION_HEAD")"
  readonly LOG_PATH_EXT='log'
  readonly LOG_PATH_BASENAME=`
   `"$(version::path_basename "$LOG_BASENAME_VERSION_HEAD" "$LOG_PATH_EXT")"
  readonly LOG_PATH="$(version::path "$LOG_PATH_DIRNAME" "$LOG_PATH_BASENAME")"
  readonly LOG_PATH_VERSION_TAIL=`
   `"$(version::path_version_tail "$LOG_PATH_EXT")"
  readonly LOG_PATH_REGEX="$(version::path_regex \
        "$LOG_PATH_DIRNAME" \
        "$LOG_BASENAME_VERSION_HEAD" \
        "$LOG_PATH_EXT")"

fi
