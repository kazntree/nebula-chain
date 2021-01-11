#!/bin/bash

CURRENT_DIR=$(pwd)
PROJECT_DIR=$(git rev-parse --show-toplevel)
cd $PROJECT_DIR

# Check prerequisites
PREREQUISITES_ERROR="Please check prerequisites in https://github.com/kazntree/nebula-chain"
if [ -z "$GREN_GITHUB_TOKEN" ];
then
  echo "environment variable of GREN_GITHUB_TOKEN does not exist." $PREREQUISITES_ERROR
  exit 1
fi

type gren > /dev/null
if [ $? -ne 0 ]; then
  echo "gren command does not exist." $PREREQUISITES_ERROR
  exit 1
fi

type gh > /dev/null
if [ $? -ne 0 ]; then
  echo "gh command does not exist." $PREREQUISITES_ERROR
  exit 1
fi

function error_check() {
  if [ $? -ne 0 ]; then
     cd $CURRENT_DIR
     exit 1
  fi
}

echo "Do you want to release and publish? [y/n]"
read answer
case $answer in
  y)
    echo "release start."
    ;;
  *)
    echo "cancelled."
    exit 1
    ;;
esac

### finalize & publish
./gradlew clean final $1
error_check

### Release on GitHub
RELEASE_VERSION="$(git describe)"
gh release create $RELEASE_VERSION -t "" -n ""
error_check

### Write release note
gren release --override
error_check

cd $CURRENT_DIR

