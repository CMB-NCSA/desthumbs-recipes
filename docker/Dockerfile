FROM ubuntu:24.04

RUN apt-get update
RUN apt-get update --fix-missing
RUN apt-get install -y libtiff-dev libjpeg-dev imagemagick gcc git
RUN apt-get install -y python-is-python3 python3-fitsio python3-astropy python3-pandas python3-yaml python3-magic python3-matplotlib python3-oracledb python3-pip
RUN pip install duckdb --prefix=/usr --no-deps --break-system-packages

RUN git clone https://github.com/CMB-NCSA/stiff.git  && \
    cd stiff && \
    ./configure --prefix=/usr/local && \
    make && \
    make install

# Install des_cutter
ARG DES_CUTTER_VERSION
RUN mkdir -p /opt/des_cutter/python && \
    git clone https://github.com/CMB-NCSA/des_cutter -b $DES_CUTTER_VERSION  &&\
    cd des_cutter &&\
    pip install . --target=/opt/des_cutter --no-deps --break-system-packages &&\
    mv /opt/des_cutter/des_cutter /opt/des_cutter/python &&\
    cd .. &&\
    rm -rf des_cutter

# Add $SPTUSER as user and create groups wheel and spt, we will use
# uid 47448 (felipe) on the ICC
ARG SPTUSER
RUN useradd -ms /bin/bash -u 47448 $SPTUSER && \
    addgroup wheel && \
    addgroup -gid 1003 spt

# Add $SPTUSER to wheel and spt
RUN usermod -aG wheel $SPTUSER && \
    usermod -aG spt $SPTUSER

# Make mount directory to mirror /data/des
RUN mkdir -p /data/des && \
    chgrp spt /data/des && \
    chmod g+wrx /data/des

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

# Set environment in the container
ENV PRODUCT_DIR="/opt/des_cutter"
ENV DES_CUTTER_DIR=${PRODUCT_DIR}
ENV PYTHONPATH=${PRODUCT_DIR}/python:${PYTHONPATH}
ENV PATH=${PRODUCT_DIR}/bin:${PATH}

# Not really needed
# RUN echo "source /opt/des_cutter/setpath.sh /opt/des_cutter" >> $HOME/.bashrc
