#!/bin/sh

#------------------------------------------------------------------------------------
# Starts the firefox docker container. To keep things simple some of the X11 stuff 
# directly shared is with the container (but in read-only mode ;)
#
# it shows some warnings but still comes up ...
# (sorrily there seems no easy way to fix the problems)
#------------------------------------------------------------------------------------

UID=$(id -u $USER)
GID=$(id -g $USER)
#DISPLAY_TO_USE=$(ifconfig docker0 | grep "inet addr:" | awk '{print $2}' | cut -d: -f2):0.0

# variant 1: share X11 socket directly 
#docker run -ti --rm -e DISPLAY=192.168.0.13:0.0 \
#           -v /tmp/.X11-unix:/tmp/.X11-unix:ro docker-firefox-$UID-$GID

# variant 2: share the .Xauthority file
docker run -ti --rm -e DISPLAY \
       -v $HOME/.Xauthority:/home/developer/.Xauthority:ro \
       --net=host docker-firefox-$UID-$GID	
