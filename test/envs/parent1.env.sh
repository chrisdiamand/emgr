function t1() {
    fail_if_var_set EMGR_ENV_PARENT
    fail_if_var_not_equal EMGR_ENV_LOCAL parent1
}

t1

inherit_env subdir/parent2

t1