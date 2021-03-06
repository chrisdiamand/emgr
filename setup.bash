#!/usr/bin/env bash

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


function _EMGR_should_restore_function() {
    case "$1" in
    _EMGR_*)
        return 1
        ;;
    _*)
        return 1
        ;;
    esac
    return 0
}

function _EMGR_should_restore_var() {
    case "$1" in
    _EMGR_*|EMGR_*)
        return 1
        ;;
    FUNCNAME|GROUPS)
        return 1
        ;;
    esac

    if _EMGR_is_readonly_var "$1"; then
        return 1
    fi

    return 0
}

function _EMGR_bash_list_functions() {
    declare -F | cut -d " " -f 3
}

function _EMGR_bash_list_vars() {
    local _EMGR_i= _EMGR_var_name=
    for _EMGR_i in _ {a..z} {A..Z}; do
        for _EMGR_var_name in `eval "echo \\${!$_EMGR_i@}"`; do
            echo "$_EMGR_var_name"
        done
    done
}

function _EMGR_clear_env() {
    local func_name=

    for func_name in `_EMGR_bash_list_functions`; do
        if _EMGR_should_restore_function "$func_name"; then
            unset -f "$func_name"
        fi
    done

    for var_name in `_EMGR_bash_list_vars`; do
        if _EMGR_should_restore_var "$var_name"; then
            unset "$var_name"
        fi
    done

    unalias -a
}

function _EMGR_write_env() {
    # We have to be careful what local variables are called, because they might
    # end up being included in the list of all variables
    local _EMGR_fname="$1" _EMGR_func_name= _EMGR_var_name=

    for _EMGR_func_name in `_EMGR_bash_list_functions`; do
        if _EMGR_should_restore_function "$_EMGR_func_name"; then
            declare -f "$_EMGR_func_name" >> "$_EMGR_fname"
        fi
    done

    for _EMGR_var_name in `_EMGR_bash_list_vars`; do
        if _EMGR_should_restore_var "$_EMGR_var_name"; then
            declare -p "$_EMGR_var_name" \
                | sed '1 s/^declare/declare -g/' \
                >> "$_EMGR_fname"
        fi
    done

    alias >> "$_EMGR_fname"
}

function _EMGR_adjust_prompt() {
    local env_colour_start='\[\e[1;90m\]'
    local env_color_end='\[\e[0m\]'

    export PS1=$env_colour_start'[$EMGR_ENV_CURRENT]:'$env_colour_end$PS1
}
