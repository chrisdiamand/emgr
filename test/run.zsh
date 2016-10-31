#!/usr/bin/env zsh

export TEST_DIR=${0:a:h}
export TEST_SHELL=zsh

"$TEST_SHELL" ./run_tests $@
