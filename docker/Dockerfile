FROM ubuntu:24.04

RUN apt-get update
RUN apt-get update --fix-missing
RUN apt-get install -y libtiff-dev libjpeg-dev imagemagick gcc git
RUN apt-get install -y python-is-python3 python3-fitsio python3-pandas python3-yaml python3-magic python3-matplotlib python3-oracledb python3-pip
RUN pip install duckdb --prefix=/usr --no-deps --break-system-packages

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

#Add svcdesdatabot to mount taiga des_archive
RUN useradd -ms /bin/bash -u 68586 svcdesdatabot && \
    addgroup -gid 2402 des_dm

RUN mkdir -p /des_archive && \
    chgrp des_dm /des_archive

USER ${SPTUSER}
WORKDIR /home/${SPTUSER}

ENV USER $SPTUSER
ENV HOME /home/$SPTUSER
ENV SHELL /bin/bash
