#!/bin/bash

PROJECT_DIR=$(readlink -f "$(dirname $0)")
DOCKER_EXEC='docker'
IMAGE_NAME='andreptb/oracle-java'
LATEST_VERSION=8
VERSION=$1
PUSH_IMAGE=$2

if [ -z $VERSION ]; then
  VERSION=$LATEST_VERSION
fi

tagAndPush() {
  TAG=$IMAGE_NAME:$1
  $DOCKER_EXEC tag -f $IMAGE_NAME:$VERSION $TAG
  echo "tag aplicado: $TAG"
  if [ "$PUSH_IMAGE" == 'push' ]; then
    $DOCKER_EXEC push $IMAGE_NAME:$1
    echo "push da imagem realizada: $TAG"
  fi
}

DOCKERFILE_DIR=$PROJECT_DIR/.tmp
rm -rf $DOCKERFILE_DIR && mkdir -p $DOCKERFILE_DIR

# sed changes JAVA_VERSION
# sed removes oracle-java6-unlimited-jce-policy, since package doesnt exist for java6
sed -e s/JAVA_VERSION\ $LATEST_VERSION/JAVA_VERSION\ $VERSION/g -e s/oracle-java\$JAVA_VERSION-unlimited-jce-policy//g $PROJECT_DIR/Dockerfile > $DOCKERFILE_DIR/Dockerfile

$DOCKER_EXEC build -t $IMAGE_NAME:$VERSION $DOCKERFILE_DIR
BUILD_RESULT=$?
# if build fails cancels
if [ "$BUILD_RESULT" != "0" ]; then
  exit $BUILD_RESULT
fi
tagAndPush $VERSION


# tag with java complete version. Example 1.8.0_45
tagAndPush $(docker run --rm -t $IMAGE_NAME:$VERSION java -version | awk 'NR==1{gsub(/[^0-9_\.]/,""); print}')
# tag latest if build is latest version
if [ $VERSION == $LATEST_VERSION ]; then
  tagAndPush 'latest'
fi
