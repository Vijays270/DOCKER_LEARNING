# DOCKER_LEARNING
Basics of Docker &lt;In the end How to Push the image to the Docker Hub from>

[vjs@server2 ~]$ su -
Password:

[root@server2 ~]# docker pull node
Using default tag: latest
latest: Pulling from library/node
903681d87777: Pull complete
3cbbe86a28c2: Pull complete
6ed93aa58a52: Pull complete
787c78da4383: Pull complete
f01e1714e9bf: Pull complete
674dd2d5a8af: Pull complete
b82529f656ad: Pull complete
cacfd624c54a: Pull complete
Digest: sha256:914458d8617650599ec2c05f6754403a1ce08cb471b0b1de1de439c539f8d45f
Status: Downloaded newer image for node:latest
docker.io/library/node:latest

[root@server2 ~]#
[root@server2 ~]# docker images
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
node             latest    6ea21c4a7af9   9 days ago      1.12GB
my-first-image   latest    c13013c57eef   3 weeks ago     7.8MB
hello-world      latest    d2c94e258dcb   15 months ago   13.3kB
[root@server2 ~]#

#Name the container for the image
[root@server2 ~]# docker run --name new node
[root@server2 ~]# docker images
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
node             latest    6ea21c4a7af9   9 days ago      1.12GB
my-first-image   latest    c13013c57eef   3 weeks ago     7.8MB
hello-world      latest    d2c94e258dcb   15 months ago   13.3kB
[root@server2 ~]# docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS                      PORTS     NAMES
a9ded41eb259   node             "docker-entrypoint.s…"   15 seconds ago   Exited (0) 14 seconds ago             new
fb473efd0957   node             "docker-entrypoint.s…"   3 minutes ago    Exited (0) 2 minutes ago              eloquent_turing
b97f36a58a2e   my-first-image   "echo 'Hello, Docker…"   31 minutes ago   Exited (0) 31 minutes ago             confident_newton
00a0ef2603dd   my-first-image   "echo 'Hello, Docker…"   33 minutes ago   Exited (0) 33 minutes ago             confident_volhard
19a254bd8a1f   hello-world      "/hello"                 39 minutes ago   Exited (0) 39 minutes ago             sleepy_banzai
[root@server2 ~]#

[root@server2 ~]# #While I am running the conatiner "run", but it is suddenly stopped after running, because need a terminal window for the node commands, if command terminal is not attached to  the node container, there is no work for the node, It is exited because of command terminal not attached with conatiner.
[root@server2 ~]#

#To_Attach_terminal_with_container: docker run -it <cont.name>
[root@server2 ~]# docker run -it node
Welcome to Node.js v22.6.0.
Type ".help" for more information.
> let a=1;
undefined
> let b=1;
undefined
> console.log(a+b)
2
undefined

# Docker container (of image node) is running
[root@server2 ~]# docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED          STATUS                      PORTS     NAMES
fb5dcfaadaa9   node             "docker-entrypoint.s…"   4 minutes ago    Up 4 minutes                          funny_ride

#CONTAINER_STOPPED BY:
[root@server2 ~]# docker stop fb5dcfaadaa9
fb5dcfaadaa9
[root@server2 ~]#
#CONTAINER_START_BY:
[root@server2 ~]# docker start funny_ride
funny_ride
[root@server2 ~]#

#RUNNING_COMMANDS_IN_CONTAINER:

[root@server2 ~]# docker exec -it  funny_ride node
Welcome to Node.js v22.6.0.
Type ".help" for more information.
> console.log(90+90)
180
undefined
>


#TO_ACCESS_CONATINER(inside)_VIA_TERMINAL
[root@server2 ~]# docker exec -it  funny_ride /bin/bash
root@fb5dcfaadaa9:/#
root@fb5dcfaadaa9:/# ls
bin  boot  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var

#TO_VIEW_node_BINARY
root@fb5dcfaadaa9:/# cd /usr/local/bin
root@fb5dcfaadaa9:/usr/local/bin# ls
corepack  docker-entrypoint.sh  node  nodejs  npm  npx  yarn  yarnpkg
root@fb5dcfaadaa9:/usr/local/bin#

#NOTE-/usr/local/bin is the universal path
we can access from anywhere in the system.
#WHEN_INSIDE_THE_PATH_OF_THE_APPLICATION
#WE_CAN_DIRECTLY_ENTER_THE_APP._NAME
root@fb5dcfaadaa9:/usr/local/bin# node
Welcome to Node.js v22.6.0.
Type ".help" for more information.
>

#TAG_CONTAINER_NAME

[root@server2 ~]# docker stop fb5dcfaadaa9
fb5dcfaadaa9
[root@server2 ~]# docker run --name node_app node
[root@server2 ~]# docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED             STATUS                         PORTS     NAME                                S
eb387a780090   node             "docker-entrypoint.s…"   5 seconds ago       Exited (0) 3 seconds ago                 node                                _app
fb5dcfaadaa9   node             "docker-entrypoint.s…"   35 minutes ago      Exited (137) 55 seconds ago              funn                                y_ride

#TO_RENAME_THE_CONTAINER:

#[root@server2 ~]# docker rename node_app f1_node_app

[root@server2 ~]# docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED             STATUS                         PORTS     NAMES
eb387a780090   node             "docker-entrypoint.s…"   4 minutes ago       Exited (0) 4 minutes ago                 f1_node_app
a9ded41eb259   node             "docker-entrypoint.s…"   51 minutes ago      Exited (0) 51 minutes ago                new

#TO_DELETE_A_PARTICULAR_CONATINER_BY_CONTAINER>NAME
[root@server2 ~]# docker rm  new
new
[root@server2 ~]# docker ps -a
CONTAINER ID   IMAGE            COMMAND                  CREATED             STATUS                         PORTS     NAMES
eb387a780090   node             "docker-entrypoint.s…"   6 minutes ago       Exited (0) 6 minutes ago                 f1_node_app
fb5dcfaadaa9   node             "docker-entrypoint.s…"   41 minutes ago      Exited (137) 7 minutes ago               funny_ride


#TO_DELETE_STOPPED_CONATINERS
#IT_GIVES_WARNING
[root@server2 ~]# docker container prune
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N]

#IF_YOU_GIVE_(YES)_IT_SHOWS_THE_DELETED_LIST:

Are you sure you want to continue? [y/N] y
Deleted Containers:
eb387a78009001d4b256489cf78921af86a6d493c5e10c998b828b1485b2bcca
fb5dcfaadaa97d8c1c5035e97a42eef957e4e20f1ac1c5f3841b1061fd174f03
fb473efd095788c91d0e310f687f23f1f2d38008d566cb5dd7420ac80ecdbe4a
b97f36a58a2e1407fd416af3247fa377f0eca81a3e728d20873ba54e2a7e37f8
00a0ef2603dd3c9e03b76ff811198b94abc619e1cfdf05fd6b450cddb41152b2
19a254bd8a1fe73a0fc5c88a31733525140589d56b279323b564e5197a192568

Total reclaimed space: 53B
[root@server2 ~]#

#COPYING_FIL_FROM_LOCAL_DIRECTORY_TO_CONTAINER
[root@server2 ~]# vi /tmp/sample
[root@server2 ~]# vi /tmp/sample
[root@server2 ~]# cat /tmp/sample
This is sample file
[root@server2 ~]#
#/tmp/sample_need_to_be_there_in_conatiner's_in_/var/sample

#CREATING_NEW_CONTAINER

[root@server2 ~]# docker pull alpine
Using default tag: latest
latest: Pulling from library/alpine
c6a83fedfae6: Already exists
Digest: sha256:0a4eaa0eecf5f8c050e5bba433f58c052be7587ee8af3e8b3910ef9ab5fbe9f5
Status: Downloaded newer image for alpine:latest
docker.io/library/alpine:latest
[root@server2 ~]# docker images
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
node             latest    6ea21c4a7af9   10 days ago     1.12GB
image1           latest    c13013c57eef   3 weeks ago     7.8MB
my-first-image   latest    c13013c57eef   3 weeks ago     7.8MB
alpine           latest    324bc02ae123   3 weeks ago     7.8MB
hello-world      latest    d2c94e258dcb   15 months ago   13.3kB

#MOVING_TO_THE_CONTAINER_INTERFACE
[root@server2 ~]# docker run -it --name my_alpine_container alpine
/ #
/ # ls
bin    dev    etc    home   lib    media  mnt    opt    proc   root   run    sbin   srv    sys    tmp    usr    var

#COPYING_FILE_FROM_LOCAL_DIRECTORY_TO_CONTAINER
[root@server2 ~]# docker cp /tmp/sample my_alpine_container:/var
Successfully copied 2.05kB to my_alpine_container:/var
[root@server2 ~]#

#CHECKING_TJE_COPIED_FILE_AVAILABLE_IN_CONTAINER
/var # find /var -type f -name sample
/var/sample


#COPY_FILE_FROM_COANTAINER_TO_LOCAL_MACHINES'S_DIRECTORY

/var # touch vjs
/var # docker cp  my_alpine_container:/var/vjs /tmp/vjs

#PUSHING_DOCKER_IMAGES	
#CREATE_NEW_IMAGE

[root@server2 ~]# mkdir /simple_app
[root@server2 ~]# cd /simple_app

[root@server2 simple_app]# vi Dockerfile

FROM alpine:latest

CMD echo "Test, File From vijay270!"


~
~
~
"Dockerfile" 5L, 59B               

[root@server2 simple_app]# docker build -t simple_image .
[+] Building 0.9s (5/5) FINISHED                                                                                  docker:default
 => [internal] load build definition from Dockerfile                                                                        0.2s
 => => transferring dockerfile: 153B                                                                                        0.0s
 => WARN: JSONArgsRecommended: JSON arguments recommended for CMD to prevent unintended behavior related to OS signals (li  0.2s
 => [internal] load metadata for docker.io/library/alpine:latest                                                            0.0s
 => [internal] load .dockerignore                                                                                           0.1s
 => => transferring context: 2B                                                                                             0.0s
 => CACHED [1/1] FROM docker.io/library/alpine:latest                                                                       0.0s
 => exporting to image                                                                                                      0.1s
 => => exporting layers                                                                                                     0.0s
 => => writing image sha256:505b5f37712fb98cb1e5241c6f8b1aa9e8fa839a74b2c8beda87f7464c76d725                                0.0s
 => => naming to docker.io/library/simple_image                                                                             0.0s

 1 warning found (use docker --debug to expand):
 - JSONArgsRecommended: JSON arguments recommended for CMD to prevent unintended behavior related to OS signals (line 3)
[root@server2 simple_app]# docker images
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
node             latest    6ea21c4a7af9   10 days ago     1.12GB
image1           latest    c13013c57eef   3 weeks ago     7.8MB
my-first-image   latest    c13013c57eef   3 weeks ago     7.8MB
simple_image     latest    505b5f37712f   3 weeks ago     7.8MB
alpine           latest    324bc02ae123   3 weeks ago     7.8MB
hello-world      latest    d2c94e258dcb   15 months ago   13.3kB
[root@server2 simple_app]#

#Login_to_your_Docker_Account:
[root@server2 simple_app]# docker login
Log in with your Docker ID or email address to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com/ to create one.
You can log in with your password or a Personal Access Token (PAT). Using a limited-scope PAT grants better security and is required for organizations using SSO. Learn more at https://docs.docker.com/go/access-tokens/

Username: vijay270
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credential-stores

Login Succeeded
[root@server2 simple_app]#

#TAG_YOUR_IMAGE_TO_THE_CREATED_REPOSITORY(Docker Hub's):

[root@server2 simple_app]# docker tag simple_image vijay270/simple_image:latest

#NOW_OUR_IMAGE_READY_TO_PUSH_TO_THE_DOCKER_HUB:
 
#TO_PUSH_IMAGE_TO_THE_REPOSITORY:

[root@server2 simple_app]# docker push vijay270/simple_image
Using default tag: latest
The push refers to repository [docker.io/vijay270/simple_image]
78561cef0761: Preparing
---
---
The push refers to repository [docker.io/vijay270/simple_image]
78561cef0761: Mounted from library/alpine
latest: digest: sha256:d95548aea255911ea36ebb0dbdeac70960d16fa04e3f7337f9b358545ecac1b9 size: 527

#NOW_CHECK_YOUR_REPOSITORY_BY_RELOADING_DOCKER_HUB_WEB_PAGE:
#YOU_CAN_SEE_THE_TAG_NAME_OF_YOUR_IMAGE(latest)

#CHECK_THE_IMAGE_ON_CLI
[root@server2 simple_app]# docker images
REPOSITORY              TAG       IMAGE ID       CREATED         SIZE
my-first-image          latest    c13013c57eef   3 weeks ago     7.8MB
vijay270/simple_image   latest    505b5f37712f   3 weeks ago     7.8MB

#NOW_WE_NEED_TO_DELETE_EXIXTING_IMAGES_OF_THE_NAME_simple_image
#THEN_ONLY_WE_CAN_PULL_REPOSITORY_IMAGES_OF_DOCKER_HUB_AND_TEST

[root@server2 simple_app]# docker rmi vijay270/simple_image
Untagged: vijay270/simple_image:latest
Untagged: vijay270/simple_image@sha256:d95548aea255911ea36ebb0dbdeac70960d16fa04e3f7337f9b358545ecac1b9
[root@server2 simple_app]# docker rmi simple_image
Untagged: simple_image:latest
Deleted: sha256:505b5f37712fb98cb1e5241c6f8b1aa9e8fa839a74b2c8beda87f7464c76d725
[root@server2 simple_app]#

#NOW_WE_START_PULLING_THE_DOCKER_HUB_REPOSITORY_IMAGE

[root@server2 simple_app]# docker pull vijay270/simple_image:latest
latest: Pulling from vijay270/simple_image
c6a83fedfae6: Already exists
Digest: sha256:d95548aea255911ea36ebb0dbdeac70960d16fa04e3f7337f9b358545ecac1b9
Status: Downloaded newer image for vijay270/simple_image:latest
docker.io/vijay270/simple_image:latest
[root@server2 simple_app]#


#CHECKING_THE_PULLED_IMAGE_BY_CLI

[root@server2 simple_app]# docker images
REPOSITORY              TAG       IMAGE ID       CREATED         SIZE
vijay270/simple_image   latest    505b5f37712f   3 weeks ago     7.8MB

#NOW_WE_RUN_CONTAINER_BY_PULLED_IMAGE_vijay270/simple_image 

[root@server2 simple_app]# docker run  -it --name simple_image_cnt vijay270/simple_image
Test, File From vijay270!
[root@server2 simple_app]# 

#SO_SUCCESSFULLY_CREATED_THE_IMAGE_AND_PUSHED_TO_DOCKER_HUB
#ALSO_CHECKED_THE_DOCKER_HUB_REPOSITORY_IMAGE(WHICH_WE_PUSHED_TO_DOCKER_HUB)
#THAT_IS_PERFECTLY_PULLED_AND_RAN_CONTAINER_BY_PULLED_IMAGE
