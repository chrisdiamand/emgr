#!/usr/bin/env zsh

function _EMGR_should_restore_function() {
    case "$1" in
    _EMGR_*)
        return 1
        ;;
    _*|zle-*|backward-kill-word-match|backward-word-match|bashcompinit|capitalize-word-match|colors|compaudit|compdef|compdump|compgen|compinit|compinstall|complete|down-case-word-match|emgr|forward-word-match|kill-word-match|precmd|run-help|select-word-style|transpose-words-match|up-case-word-match|zle-line-finish|zle-line-init)
        return 1
        ;;
    *)
        return 0
        ;;
    esac
}

function _EMGR_should_restore_var() {
    case "$1" in
    _EMGR_*|EMGR_*)
        return 1
        ;;
    _*|0|aliases|bg|bg_bold|bg_no_bold|bold_color|fg|fg_bold|fg_no_bold|fignore|functions|options|reset_color|saliases|OLDPWD|RANDOM|SECONDS|ZLE_*|argv|cdpath|CDPATH|colour|_comp_setup|commands|pipestatus|\?|\*|\#|!|@|\$|ARGC|builtins|funcstack|zsh_eval_context|HISTCMD|parameters|compprefuncs)
        return 1
        ;;
    esac

    if _EMGR_is_readonly_var "$1"; then
        return 1
    fi

    return 0
}

function _EMGR_zsh_list_vars() {
    print -l ${(k)parameters}
}

function _EMGR_write_env() {
    local _EMGR_fname="$1"
    # Go through the defined functions, excluding difficult builtins,
    # completion, etc, and write out its definition.
    for _EMGR_func_name in `print -l ${(ok)functions}`; do
        if _EMGR_should_restore_function "$_EMGR_func_name"; then
            type -f "$_EMGR_func_name" >> "$_EMGR_fname"
        fi
    done

    for _EMGR_var_name in `_EMGR_zsh_list_vars`; do
        if _EMGR_should_restore_var "$_EMGR_var_name"; then
            declare -p "$_EMGR_var_name" \
                >> "$_EMGR_fname"
        fi
    done

    alias -L >> "$_EMGR_fname"
}

# Unset every restorable function and variable
function _EMGR_clear_env() {
    local func_name= var_name=

    for func_name in `print -l ${(ok)functions}`; do
        if _EMGR_should_restore_function "$func_name"; then
            unset -f "$func_name"
        fi
    done

    for var_name in `_EMGR_zsh_list_vars`; do
        if _EMGR_should_restore_var "$var_name"; then
            unset "$var_name"
        fi
    done

    unalias -m '*'
}

function _EMGR_adjust_prompt() {
    export prompt="%{$fg_no_bold[blue]%}[$EMGR_env_current]:%{$reset_color%}$prompt"
}
