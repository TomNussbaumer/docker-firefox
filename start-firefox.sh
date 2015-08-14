#!/bin/sh

# start the firefox docker container
#
# it shows some warnings but still comes up ...

UID=$(id -u $USER)
GID=$(id -g $USER)
#DISPLAY_TO_USE=$(ifconfig docker0 | grep "inet addr:" | awk '{print $2}' | cut -d: -f2):0.0

### variant 1
# share X11 socket directly 
#
# (NOTE: the -u root is just for the bootstrapping. Firefox will run not run as root.)
docker run -ti --rm -e DISPLAY\
           -v /tmp/.X11-unix:/tmp/.X11-unix:ro -u root docker-firefox-$UID-$GID

### variant 2
# share the .Xauthority file
# (NOTE: the -u root is just for the bootstrapping. Firefox will not run as root.)
#docker run -ti --rm --cap-add SYS_PTRACE --security-opt apparmor:unconfined -e DISPLAY \
#       -v $HOME/.Xauthority:/home/developer/.Xauthority:ro \
#       --net=host -u root docker-firefox-$UID-$GID

### to debug I was in need to run strace, but the host's apparmor setting denied it
### variant A (the better one):
#docker run -ti --rm --cap-add SYS_PTRACE --security-opt apparmor:unconfined -e DISPLAY \
#       -v $HOME/.Xauthority:/home/developer/.Xauthority:ro \
#       --net=host -u root docker-firefox-$UID-$GID /sbin/my_init -- \
#       /sbin/setuser developer bash 

### variant B
#docker run -ti --rm --privileged -e DISPLAY \
#       -v $HOME/.Xauthority:/home/developer/.Xauthority:ro \
#       --net=host -u root docker-firefox-$UID-$GID /sbin/my_init -- \
#       /sbin/setuser developer bash 
