#!/bin/bash
IMAGENAME=debian-frontend.devel
IMAGETAG=latest
IMAGEVERSION=v0.1
CMD="/tmp/scripts/run.sh"
BRANCH=master

usage(){
	echo "./setup.sh [NODE BRANCH NAME]"
}

# check the branch name
if [ $# -eq 1 ]; then
	BRANCH=$1
	MACHINE_NAME="nodejs_$BRANCH"
else
	usage
	exit 1
fi

# check if docker is running
docker info > /dev/null 2>&1
if [ $? -ne 0 ]
then
	echo "Cannot connect to the Docker daemon. Is the docker daemon running on this host?"
	exit -1
fi

# check if the Dockerfile is in the folder
if [ ! -f Dockerfile ]
then
	echo "Dockerfile is not present, please run the script from right folder"
	exit -1
fi

# check if the docker image exists
docker images | grep "$IMAGENAME" | grep "$IMAGETAG" > /dev/null 2>&1
if [ $? -ne 0 ]
then
	# create the docker image
	docker build --no-cache -t $IMAGENAME:$IMAGEVERSION -t $IMAGENAME:$IMAGETAG ./
	if [ $? -ne 0 ]
	then
		echo "docker build failed!"
		exit -1
	fi
fi

# if machine is running, just attach
CONTAINER=$(docker ps | grep "$MACHINE_NAME" | awk '{ print $1 }')
if [ "$CONTAINER" ]; then
	# attach to running container
	echo "==> attaching to container $CONTAINER"
	docker exec -ti $CONTAINER /bin/bash
else
	CONTAINER=$(docker ps -a | grep "$MACHINE_NAME" | awk '{ print $1 }')
	if [ "$CONTAINER" ]; then
		echo "==> restarting container $CONTAINER"
		# start and attach to stopped container
		docker start $CONTAINER
		sleep 1
		docker exec -ti $CONTAINER /bin/bash
	else
		# run a container from $IMAGENAME image
		echo "==> creating container $CONTAINER"
		docker run --privileged=true -di -P --name "$MACHINE_NAME" -v $PWD/code:/opt/nodejs -v $PWD/scripts:/tmp/scripts -e "NODE_BRANCH=$BRANCH" "$IMAGENAME:$IMAGETAG" $CMD
		CONTAINER=$(docker ps | grep "$MACHINE_NAME" | awk '{ print $1 }')
		docker logs -f $CONTAINER
	fi

fi

