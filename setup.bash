#!/usr/bin/env bash

function _EMGR_write_env() {
    local fname="$1"
    declare >> "$fname"
}

function _EMGR_adjust_prompt() {
    local env_colour_start='\[\e[1;90m\]'
    local env_color_end='\[\e[0m\]'

    export PS1=$env_colour_start'[$_EMGR_env_current]:'$env_colour_end$PS1
}
