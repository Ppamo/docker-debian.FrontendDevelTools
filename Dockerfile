FROM docker.io/debian:latest
MAINTAINER "Ppamo" <pablo@ppamo.cl>

# Update system
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install python bc procps vim build-essential git
