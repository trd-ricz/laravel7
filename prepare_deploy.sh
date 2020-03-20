
#!/bin/bash
#
# Prepare to deploy files by zip
# Run on docker workspace
#

###---------------------------------------###
### settings
###---------------------------------------###

LARADOCK_DIR=laravel7_ld/
LARAVEL_DIR=laravel/

###---------------------------------------###
### functions
###---------------------------------------###

##
# Check require params
#
checkRequireParams () {
  if [ -z $1 ]; then
    echo "Required ENV(production or development ...)"
    exit;
  else
    ENV=$1
  fi
}

##
# composer install
#
installComposer () {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  composer install
  php artisan passport:keys
  php artisan storage:link
  php artisan cache:clear
  php artisan config:clear
  php artisan config:cache
}

##
# npm install
#
installNpm () {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  npm install
  npm run ${ENV}
}


##
# replace laravel env
#
replaceLaravelEnv () {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  echo "replace laravel environment"
  cp .env .env.tmp
  cp .env.${ENV} .env
}

##
# replace laravel echo json env
#
replaceWebsocketEnv () {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  echo "replace websocket environment"
  cp laravel-echo-server.json laravel-echo-server.json.tmp
  cp laravel-echo-server.json.${ENV} laravel-echo-server.json
}

##
# compress
#
compressDeployFiles() {
  cd ${abspath}
  echo "development commpress"
  zip -r -q ./deploy.zip -r * .[^.]*
}


##
# roll back laravel settings
#
rollBackLaravelSettings() {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  mv -f .env.tmp .env
  mv -f laravel-echo-server.json.tmp laravel-echo-server.json
}

###---------------------------------------###
### exec
###---------------------------------------###

abspath=$(cd $(dirname $0); pwd)

# Param $1 from console
checkRequireParams $1

## Replace laravel env
replaceLaravelEnv

## Replace websocket env
replaceWebsocketEnv

# Install composer
installComposer

# Install npm
installNpm

## compress files
compressDeployFiles

## Roll back laravel settings
rollBackLaravelSettings

exit;


