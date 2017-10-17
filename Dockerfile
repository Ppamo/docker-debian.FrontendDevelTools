FROM node:6
MAINTAINER "Ppamo" <pablo@ppamo.cl>

# Update system
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install python bc procps vim build-essential git
COPY scripts/run.sh /tmp

EXPOSE 3000

CMD ["/tmp/run.sh"]
