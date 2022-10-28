# Issues with Jammy
# the latest python3-full doesn't work. python3.10 seems to break something with json str encoding
#FROM phusion/baseimage:jammy-1.0.1
FROM phusion/baseimage:focal-1.2.0
MAINTAINER pinion <pinion@gmail.com>
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root
# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
# Fix a Debianism of the nobody's uid being 65534
RUN usermod -u 99 nobody
RUN usermod -g 100 nobody
# install dependencies for building/running cherrymusic
RUN apt-get update -qq
RUN apt-get -y install \
ffmpeg \
imagemagick \
git \
python3-pip \
python3.8-full \
python3-unidecode \
imagemagick
RUN apt-get -y install flac lame vorbis-tools
RUN apt-get clean
RUN pip install cherrypy
# download and install cherrymusic
RUN git clone --branch devel https://github.com/devsnd/cherrymusic.git /opt/cherrymusic
RUN chown nobody:users /opt/cherrymusic
RUN mkdir -p ~/.config/cherrymusic
EXPOSE 8070
# cherrymusic Configuration
VOLUME ~/.config/cherrymusic/
# Music directory
VOLUME /music
# Add cherrymusic to runit
RUN mkdir /etc/service/cherrymusic
ADD cherrymusic.sh /etc/service/cherrymusic/run
RUN chmod +x /etc/service/cherrymusic/run
