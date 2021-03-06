#!/bin/bash
# shellcheck disable=SC2034
# shellcheck disable=SC2154

##########################################################################
# Testing settings
#
# NOTE: Variables are passed to the tests without the test_TARGET_ prefix.
##########################################################################

# Environment specific settings
case $taito_env in
  local)
    # local environment
    ci_test_base_url=http://taito-cli-test-ingress:80
    ;;
  *)
    # dev and feature environments
    if [[ $taito_env == "dev" ]] || [[ $taito_env == "f-"* ]]; then
      ci_exec_test=false        # enable this to execute test suites of ./server
      ci_exec_test_init=false   # run 'init --clean' before each test suite
      ci_test_base_url=https://username:secretpassword@$taito_domain
    fi
    ;;
esac

# Database connection
test_all_DATABASE_HOST=$taito_project-database-proxy
test_all_DATABASE_PORT=5432
test_all_DATABASE_NAME=$db_database_name
test_all_DATABASE_USER=${db_database_name}_app
if [[ "$taito_target_env" == "local" ]]; then
  # On local env we connect directly to the local database
  test_all_DATABASE_HOST=$taito_project-database
  :
fi

# URLs
test_client_CYPRESS_baseUrl=$ci_test_base_url
test_server_TEST_API_URL=$ci_test_base_url/api
if [[ "$taito_target_env" == "local" ]]; then
  CYPRESS_baseUrl=$taito_app_url
  if [[ $taito_target == "admin" ]]; then
    CYPRESS_baseUrl=$taito_app_url/admin
    :
  fi
  :
else
  CYPRESS_baseUrl=$ci_test_base_url
  if [[ $taito_target == "admin" ]]; then
    CYPRESS_baseUrl=$ci_test_base_url/admin
    :
  fi
  :
fi

# cypress hack to avoid basic auth on Electron browser startup:
# https://github.com/cypress-io/cypress/issues/1639
CYPRESS_baseUrlHack=$CYPRESS_baseUrl
CYPRESS_baseUrl=https://www.google.com
test_client_CYPRESS_baseUrlHack=$test_client_CYPRESS_baseUrl
test_client_CYPRESS_baseUrl=https://www.google.com
