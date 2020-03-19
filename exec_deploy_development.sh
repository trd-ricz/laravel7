#!/bin/bash

#
#  !!!!! need run in your local. not workspace on docker
#

#path to key file
if [ -z $1 ]; then
  SSH_KEY=
else
  SSH_KEY="-i $1"
fi

echo $SSH_KEY

####################################
# depends params
####################################

# dir
DEPLOY_DIR=/root/laravel7

# SSH_USER
SSH_USER=projects@45.32.11.38

# root dir
ROOT_DIR=laravel

# link path
LINK_PATH=/usr/share/nginx/html/

####################################
# fixed params
####################################

TAR_FILE=deploy.zip
TMP_DIR=tmp_deploy
DATETIME=`date +%Y-%m-%d_%H.%M.%S`


####################################
# backup
####################################
cmds=()
cmds+=("cd ${DEPLOY_DIR};")


## backup
cmds+=("echo remove old backups...;")
cmds+=("bash ./delete_backup.sh;")

cmds+=("echo backup...;")
cmds+=("mkdir backup_${DATETIME};")
cmds+=("sudo cp -rp ${ROOT_DIR}/ backup_${DATETIME};")

## exec
ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}


####################################
# upload
####################################

# upload
/usr/bin/scp ${SSH_KEY} ${TAR_FILE} ${SSH_USER}:${DEPLOY_DIR}


####################################
# deploy
####################################

cmds=()
cmds+=("cd ${DEPLOY_DIR};")

# unzip
cmds+=("echo unzip...;")
cmds+=("sudo rm -rf ${TMP_DIR}/;")
cmds+=("mkdir ${TMP_DIR}/;")
cmds+=("unzip -o ${TAR_FILE} -d ${TMP_DIR}/;")

## deploy
cmds+=("echo deploy...;")
cmds+=("sudo rm -rf ${ROOT_DIR}/;")
cmds+=("cp -rp ${TMP_DIR}/${ROOT_DIR}/ ${ROOT_DIR}/;")
cmds+=("cp -p ${TMP_DIR}/delete_backup.sh ./delete_backup.sh;")

ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}


####################################
# strage copy from old to new
####################################
cmds=()
cmds+=("cd ${DEPLOY_DIR};")

cmds+=("cp -rp backup_${DATETIME}/laravel/storage laravel/;")

ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}


####################################
# permissions
####################################
cmds=()
cmds+=("cd ${DEPLOY_DIR};")

cmds+=("sudo chmod -R 777 ./laravel/storage;")

#exec
ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}


####################################
# remove no needs
####################################

cmds=()
cmds+=("cd ${DEPLOY_DIR};")

## remove no need files
cmds+=("echo remove deploy files...;")
cmds+=("rm ${TAR_FILE};")
cmds+=("sudo rm -rf ${TMP_DIR}/;")

#exec
ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}

## make symlink
cmds=()
cmds+=("echo making symlink to root;")
## remove symlink in root dir
cmds+=("sudo rm -rf ${LINK_PATH}${ROOT_DIR};")
## make symlink in root dir
cmds+=("sudo ln -s ${DEPLOY_DIR}/${ROOT_DIR} ${LINK_PATH};")

#exec
ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}


## config cache
cmds=()
cmds+=("echo config cache;")
cmds+=("cd ${LINK_PATH}${ROOT_DIR};")
cmds+=("php artisan cache:clear;")
cmds+=("php artisan config:cache;")

#exec
ssh ${SSH_KEY} ${SSH_USER} -o "StrictHostKeyChecking no" ${cmds[*]}
