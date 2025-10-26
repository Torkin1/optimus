#! /bin/sh

# set UPGRADE_ON_RESTART to true to update phorge
# UPGRADE_ON_RESTART=true
# export UPGRADE_ON_RESTART
# 
# PH_CLUSTER_MAILERS=true
# export PH_CLUSTER_MAILERS

# original image entrypoint does not support reading password from file/secret
PH_MYSQL_PASS="$(cat /run/secrets/db_root_password)"
export PH_MYSQL_PASS

PH_BASE_URI=https://torkin.optimus.phorge.internal
export PH_BASE_URI

PH_MYSQL_HOST=phorge_mariadb
export PH_MYSQL_HOST

# yield control to original entrypoint
/usr/local/bin/docker-entrypoint.sh

# we have to call original CMD explicitly because defining entrypoint makes
# compose ignore original CMD as well
# https://docs.docker.com/reference/compose-file/services/#entrypoint 
php-fpm -F
 