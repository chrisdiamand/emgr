# Copyright 2016-2017 Chris Diamand
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

if [[ ! ( "$EMGR_ENV_LOCAL" == "alias_func_list_var" ||
          "$EMGR_ENV_LOCAL" == "reload_env" ) ]]; then
    tc_fail
fi

export TEST1="hello world!"

alias myalias='ls -l'

function myfunction() {
    echo "$TEST1"
}

MYLIST=(
    elem1
    elem2
)

myappendarray=(
    add_to_the_start
    ${myappendarray[@]}
    added_by_env
    "something with spaces"
)

export mypath="/usr/local/added_by_env:$mypath"
