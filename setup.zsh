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

function _EMGR_is_readonly() {
    (unset "$1" >&/dev/null) || return 0
    return 1
}

function _EMGR_should_restore_var() {

    case "$1" in
    _EMGR_env_backup)
        return 1
        ;;
    _*|cdpath|CDPATH|colour|_comp_setup|commands|pipestatus|\?|\*|\#|!|@|\$|ARGC|builtins|funcstack|zsh_eval_context|HISTCMD)
        return 1
        ;;
    esac

    if _EMGR_is_readonly "$1"; then
        return 1
    fi
}

function _EMGR_write_env() {
    local fname="$1"
    echo "# env `date`" > "$fname"

    # Go through the defined functions, excluding difficult builtins,
    # completion, etc, and write out its definition.
    for func_name in `print -l ${(ok)functions}`; do
        if _EMGR_should_restore_function "$func_name"; then
            type -f "$func_name" >> "$fname"
        fi
    done

    for var_name in `print -l ${(ok)parameters}`; do
        if _EMGR_should_restore_var "$var_name"; then
            declare -p "$var_name" >> "$fname"
        fi
    done
}

# Unset every restorable function and variable
function _EMGR_clear_env() {
    local func_name= var_name=

    for func_name in `print -l ${(ok)functions}`; do
        if _EMGR_should_restore_function "$func_name"; then
            unset -f "$func_name"
        fi
    done

    for var_name in `print -l ${(ok)parameters}`; do
        if _EMGR_should_restore_var "$var_name"; then
            unset "$var_name"
        fi
    done
}

function _EMGR_adjust_prompt() {
    export prompt="%{$fg_no_bold[blue]%}[$_EMGR_env_current]:%{$reset_color%}$prompt"
}
