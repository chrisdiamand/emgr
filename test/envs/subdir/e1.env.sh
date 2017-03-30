# Copyright 2017 Chris Diamand
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

fail_if_var_not_equal EMGR_ENV_LOCAL "subdir/e1"

inherit_env e2_from_closest_dir || tc_fail

fail_if_var_not_equal EMGR_ENV_LOCAL "subdir/e1"

export E1_VALUE="$E2_VALUE VALUE"

inherit_env ../alias_func_list_var || tc_fail

myfunction
