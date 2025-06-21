##########################################################################################################################################
#   Startup image is the ubuntu based sonarr
##########################################################################################################################################
FROM lscr.io/linuxserver/sonarr as base

LABEL version="1.0"
LABEL maintainer="laurent.laborde@gmail.com"
LABEL description="Sonarr image offering ffmpegx + mp4 automator"

WORKDIR /
VOLUME /mp4_automator

##########################################################################################################################################
#   1- Install ffmpeg
#   2- Install PIP
#   3- Install Pythons module necessary to run mo4_automator
#   4- Deploy MP4_Automator in /mp4_automator
##########################################################################################################################################

RUN     apk update && \
        apk add ca-certificates expat

# Install FFMPeg, Python3 and PIP
RUN apk add ffmpeg python3 py3-pip unzip git

WORKDIR /

# Install PIP modules and mp4 automator
RUN curl -o master.zip https://codeload.github.com/mdhiggins/sickbeard_mp4_automator/zip/master  ; unzip master.zip; rm master.zip; pip3 install --break-system-packages -r /sickbeard_mp4_automator-master/setup/requirements.txt; rm -rf /sickbeard_mp4_automator-master

ENTRYPOINT ["/init"]
