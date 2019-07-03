FROM golang:1.11


ENV FFMPEG_VERSION 4.0.2

#####################################################################################################################
################################################# INSTALLING FFMPEG ##################################################
RUN \
    cd /opt/ && \
    apt-get update ; apt-get install -y git build-essential gcc make yasm autoconf automake cmake libtool libass-dev libfreetype6-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev checkinstall libx264-dev libmp3lame-dev pkg-config libunwind-dev zlib1g-dev libssl-dev texi2html && \
    wget https://www.ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz && \
    tar -xzf ffmpeg-${FFMPEG_VERSION}.tar.gz; rm -r ffmpeg-${FFMPEG_VERSION}.tar.gz && \
    cd ./ffmpeg-${FFMPEG_VERSION}; ./configure --enable-gpl --enable-libmp3lame --enable-decoder=mjpeg,png --enable-encoder=png --enable-libx264 --enable-openssl --enable-nonfree --enable-pthreads && \
    cd ./ffmpeg-${FFMPEG_VERSION}; make && \
    cd ./ffmpeg-${FFMPEG_VERSION}; make install

RUN export FFMPEG_ROOT=$HOME/ffmpeg
RUN export CGO_LDFLAGS="-L$FFMPEG_ROOT/lib/ -lavcodec -lavformat -lavutil -lswscale -lswresample -lavdevice -lavfilter"
RUN export CGO_CFLAGS="-I$FFMPEG_ROOT/include"
RUN export LD_LIBRARY_PATH=$HOME/ffmpeg/lib
######################################################################################################################
######################################################################################################################
