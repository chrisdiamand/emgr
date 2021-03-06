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

fail_if_var_not_equal EMGR_ENV_LOCAL "subdir/e2_from_closest_dir"

export E2_VALUE="CORRECT"

inherit_env subdir2/sd2

fail_if_var_not_set SD3_VAR
fail_if_var_not_equal SD3_VAR "SD3"
