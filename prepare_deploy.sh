
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
# Up docker
#
upDocker () {
  cd ${abspath}
  cd ${LARADOCK_DIR}
  docker network create shared
  docker-compose up -d
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
# replace docker env
#
replaceDockerEnv () {
  cd ${abspath}
  cd ${LARADOCK_DIR}
  cp .env .env.tmp
  cp .env.${ENV} .env
}

##
# replace laravel env
#
replaceLaravelEnv () {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  cp .env .env.tmp
  cp .env.${ENV} .env
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
# roll back docker settings
#
rollBackDockerSettings() {
  cd ${abspath}
  cd ${LARADOCK_DIR}
  mv -f .env.tmp .env
}

##
# roll back laravel settings
#
rollBackLaravelSettings() {
  cd ${abspath}
  cd ${LARAVEL_DIR}
  mv -f .env.tmp .env
}

###---------------------------------------###
### exec
###---------------------------------------###

abspath=$(cd $(dirname $0); pwd)

# Param $1 from console
checkRequireParams $1

# Replace docker env
#replaceDockerEnv

## Replace laravel env
replaceLaravelEnv

# Up docker
#upDocker

# Install composer
installComposer

# Install npm
installNpm

## compress files
compressDeployFiles

## Roll back laravel settings
rollBackLaravelSettings

exit;


