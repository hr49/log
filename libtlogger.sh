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

  readonly BASENAME_DELIMITER='.'
  readonly REGEXESCAPED_BASENAME_DELIMITER='\.'
  readonly LOG_PATH_DIRNAME="$HOME"'/var/log'
  readonly LOG_BASENAME_VERSION_HEAD='tty'
  readonly LOG_PATH_BASENAME_VERSION_HEAD=`
   `"$LOG_BASENAME_VERSION_HEAD$BASENAME_DELIMITER"
  readonly LOG_PATH_VERSION_HEAD=`
   `"$LOG_PATH_DIRNAME"'/'"$LOG_PATH_BASENAME_VERSION_HEAD"
  readonly LOG_PATH_BASENAME_VERSION_HEAD_REGEX=`
   `"$LOG_BASENAME_VERSION_HEAD$REGEXESCAPED_BASENAME_DELIMITER"
  readonly LOG_PATH_VERSION_HEAD_REGEX=`
   `"$LOG_PATH_DIRNAME"'/'"$LOG_PATH_BASENAME_VERSION_HEAD_REGEX"
  readonly LOG_PATH_EXT='log'
  readonly LOG_PATH="$LOG_PATH_DIRNAME"`
                   `'/'`
                   `"$LOG_BASENAME_VERSION_HEAD"`
                   `"$BASENAME_DELIMITER"`
                   `"$LOG_PATH_EXT"
  readonly LOG_BASENAME_VERSION_TAIL="$LOG_PATH_EXT"
  readonly LOG_PATH_VERSION_TAIL=`
   `"$BASENAME_DELIMITER$LOG_BASENAME_VERSION_TAIL"
  readonly LOG_PATH_VERSION_TAIL_REGEX=`
   `"$REGEXESCAPED_BASENAME_DELIMITER$LOG_BASENAME_VERSION_TAIL"
  readonly LOG_PATH_VERSION_REGEX='[1-9][0-9]*'
  readonly LOG_PATH_REGEX="$LOG_PATH_VERSION_HEAD_REGEX"`
                         `"$LOG_PATH_VERSION_REGEX"`
                         `"$LOG_PATH_VERSION_TAIL_REGEX"

  tlogger::get_log_path() {
    echo "$LOG_PATH_VERSION_HEAD$1$LOG_PATH_VERSION_TAIL"
  }

  tlogger::get_log_version() {
    # If BASH functions could take named arguments, then `$1` would be
    # `$log_path`, and I would strip the version head and then overwrite the
    # variable.  However, one cannot overwrite `$1`, so I assign `$log_path`
    # first here.
    local -r log_path="${1#$LOG_PATH_VERSION_HEAD}"

    echo "${log_path%$LOG_PATH_VERSION_TAIL}"
  }

  tlogger::get_the_log_versions() {
    while IFS= read -d $'\0' -r log_path; do
      tlogger::get_log_version "$log_path"
    done < <(
        find "$LOG_PATH_DIRNAME" -maxdepth 1 -regex "$LOG_PATH_REGEX" -print0)
  }

  tlogger::get_the_log_versions_descending() {
    tlogger::get_the_log_versions | sort --numeric-sort --reverse
  }

fi
