#!/usr/bin/env bash

# functions
function readVarFromEnvFile() {
    VAR=$(grep $1 .env | xargs)
    IFS="=" read -ra VAR <<< "$VAR"
    echo ${VAR[1]}
}

function setEnvVariables() {
    IMAGE_NAME=$(readVarFromEnvFile IMAGE_NAME)
    if [ ! -v DOCKER_TAG ]; then
        DOCKER_TAG=$(readVarFromEnvFile DOCKER_TAG)
        echo "DOCKER_TAG variable not set, setting default as ${DOCKER_TAG}"
    fi
    if [ ! -v REMOTE_DOCKER_REGISTRY ]; then
        REMOTE_DOCKER_REGISTRY=$(readVarFromEnvFile REMOTE_DOCKER_REGISTRY)
        echo "REMOTE_DOCKER_REGISTRY not set, setting default vlaue as $REMOTE_DOCKER_REGISTRY"
    fi
}

function displaySupportedCommands() {
    echo "Supported commands: buildLocal, removeLocal, buildAndDeploy, pull"
}

function buildLocal() {
    # for update just invoke again
    echo "executing buildLocal for $IMAGE_NAME:$DOCKER_TAG"
    docker build -t "$IMAGE_NAME:$DOCKER_TAG"  .
    echo "buildLocal execution finished"
}

function removeLocal() {
    if [ ! -z `docker images $IMAGE_NAME:$DOCKER_TAG -q` ]; then
        echo "executing removelocal (delete all local images) by current tag $DOCKER_TAG"
        docker rmi --force $(docker images $IMAGE_NAME:$DOCKER_TAG -q | uniq)
    else
        echo "no images found, nothing done"
    fi
}

function removeLocalAllTags() {
    if [ ! -z `docker images $IMAGE_NAME -q` ]; then
        echo "executing delete all images no matter which tag is set"
        docker rmi --force $(docker images $IMAGE_NAME -q | uniq)
    else
        echo "no images found, nothing done"
    fi
}

function buildAndDeploy() {
    buildLocal
    echo "Deploying image $IMAGE_NAME:$DOCKER_TAG to registry $REMOTE_DOCKER_REGISTRY"
    docker tag $IMAGE_NAME $REMOTE_DOCKER_REGISTRY/$IMAGE_NAME:$DOCKER_TAG
    docker push $REMOTE_DOCKER_REGISTRY/$IMAGE_NAME:$DOCKER_TAG
}

function pull() {
    echo "Pulling image $IMAGE_NAME:$DOCKER_TAG from $REMOTE_DOCKER_REGISTRY"
    docker pull $REMOTE_DOCKER_REGISTRY/$IMAGE_NAME:$DOCKER_TAG
}

setEnvVariables

case $1 in
'buildLocal')
    buildLocal
    ;;
'removeLocalAllTags')
    removeLocalAllTags
    ;;
'removeLocal')
    removeLocal
    ;;
'buildAndDeploy')
    buildAndDeploy
    ;;
'pull')
    pull
    ;;
*)
    displaySupportedCommands
    ;;
esac
