function t1() {
    fail_if_var_set EMGR_ENV_PARENT
    fail_if_var_not_equal EMGR_ENV_LOCAL parent1
    echo "EMGR_ENV_PARENT = $EMGR_ENV_PARENT"
    fail_if_var_not_exported EMGR_ENV_CURRENT
    fail_if_var_not_exported EMGR_ENV_LOCAL
}

echo "[2] Checking inside parent1"

t1

echo "[10] Loading subdir/parent2"

inherit_env subdir/parent2

echo "[20] Checking after load of subdir/parent2"

t1
