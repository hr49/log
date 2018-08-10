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

readonly TTY_LOGGER_DIRECTORY="$HOME"'/var/log'
readonly TTY_LOG_BASENAME_DELIMITER='.'
readonly REGEXESCAPED_TTY_LOG_BASENAME_DELIMITER='\.'
readonly TTY_LOG_BASENAME_VERSION_HEAD='tty'
readonly PATH_TTY_LOG_BASENAME_VERSION_HEAD="$TTY_LOG_BASENAME_VERSION_HEAD"`
                                           `"$TTY_LOG_BASENAME_DELIMITER"
readonly TTY_LOG_PATH_VERSION_HEAD="$TTY_LOGGER_DIRECTORY"`
                                  `'/'`
                                  `"$PATH_TTY_LOG_BASENAME_VERSION_HEAD"
readonly REGEX_TTY_LOG_BASENAME_VERSION_HEAD=`
 `"$TTY_LOG_BASENAME_VERSION_HEAD"`
 `"$REGEXESCAPED_TTY_LOG_BASENAME_DELIMITER"
readonly TTY_LOG_PATH_REGEX_VERSION_HEAD="$TTY_LOGGER_DIRECTORY"`
                                        `'/'`
                                        `"$REGEX_TTY_LOG_BASENAME_VERSION_HEAD"
readonly TTY_LOG_EXT='log'
readonly TTY_LOG_BASENAME_VERSION_TAIL="$TTY_LOG_EXT"
readonly TTY_LOG_PATH_VERSION_TAIL="$TTY_LOG_BASENAME_DELIMITER"`
                                  `"$TTY_LOG_BASENAME_VERSION_TAIL"
readonly TTY_LOG_PATH_REGEX_VERSION_TAIL=`
 `"$REGEXESCAPED_TTY_LOG_BASENAME_DELIMITER"`
 `"$TTY_LOG_BASENAME_VERSION_TAIL"
readonly TTY_LOG_PATH_REGEX="$TTY_LOG_PATH_REGEX_VERSION_HEAD"`
                           `'[1-9][0-9]*'`
                           `"$TTY_LOG_PATH_REGEX_VERSION_TAIL"

tlogger::get_tty_log_path_version() {
  tty_log_path="${1#$TTY_LOG_PATH_VERSION_HEAD}"
  echo "${tty_log_path%$TTY_LOG_PATH_VERSION_TAIL}"
}

tlogger::get_the_tty_log_versions() {
  while read tty_log_path; do
    tlogger::get_tty_log_path_version "$tty_log_path"
  done < <(find "$TTY_LOGGER_DIRECTORY" -regex "$TTY_LOG_PATH_REGEX")
}
