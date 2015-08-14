#!/bin/sh

#-----------------------------------------------------------------------------
# Builds a customized image containing firefox and tailored to the active user
#-----------------------------------------------------------------------------

UID=$(id -u $USER)
GID=$(id -g $USER)

cat Dockerfile.template | sed -e "s/(UID)/$UID/g" -e "s/(GID)/$GID/g" > Dockerfile
docker build -t docker-firefox-$UID-$GID .
if [ $? -eq 0 ]; then
  echo 
  echo "[SUCCESS] built customized image for user-id $UID and group-id $GID"
  docker images | grep docker-firefox-$UID-$GID
fi
rm Dockerfile
