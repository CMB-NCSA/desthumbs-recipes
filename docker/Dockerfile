FROM ubuntu:24.04

RUN apt-get update --fix-missing
RUN apt-get -y install libtiff-dev libjpeg-dev imagemagick gcc make screen time git
RUN apt-get install -y python-is-python3
RUN apt-get install -y python3-fitsio python3-pandas python3-yaml python3-magic python3-matplotlib
# This trick install distutils under the hood
RUN apt-get install -y python3-pip

RUN git clone https://github.com/CMB-NCSA/stiff.git  && \
    cd stiff && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# Add $SPTUSER as user and create groups wheel and spt, we will use
# uid 47448 (felipe) on the ICC
ARG SPTUSER
RUN useradd -ms /bin/bash -u 47448 $SPTUSER && \
    addgroup wheel && \
    addgroup -gid 1003 spt

# Add $SPTUSER to wheel and spt
RUN usermod -aG wheel $SPTUSER && \
    usermod -aG spt $SPTUSER

# Make mount directory to mirror /data/spt3g
RUN mkdir -p /data/spt3g && \
    chgrp spt /data/spt3g && \
    chmod g+wrx /data/spt3g

USER ${SPTUSER}
WORKDIR /home/${SPTUSER}

ENV USER $SPTUSER
ENV HOME /home/$SPTUSER
ENV SHELL /bin/bash
