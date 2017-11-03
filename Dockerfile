FROM node:6
MAINTAINER "Ppamo" <pablo@ppamo.cl>

# Update system
RUN apt-get update && apt-get -y dist-upgrade
# install base development tools
RUN apt-get -y install python bc procps vim build-essential git
# install specific development tools
RUN apt-get -y install ruby-full && \
	gem install --no-rdoc --no-ri sass -v 3.4.22 && \
	gem install compass css_parser && \
	npm install -g gulp

COPY scripts/run.sh /tmp
COPY scripts/.bashrc /root/

EXPOSE 3000

CMD ["/tmp/run.sh"]
