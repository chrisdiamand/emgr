
function t2() {
    fail_if_var_not_equal EMGR_ENV_PARENT parent1
    fail_if_var_not_equal EMGR_ENV_LOCAL subdir/parent2
    fail_if_var_not_equal EMGR_ENV_CURRENT parent1
    fail_if_var_not_exported EMGR_ENV_CURRENT
    fail_if_var_not_exported EMGR_ENV_LOCAL
    fail_if_var_not_exported EMGR_ENV_PARENT
}

t2

inherit_env ../subdir2/parent3

t2
