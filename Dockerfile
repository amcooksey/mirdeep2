 ## Dockerfile
FROM ubuntu:16.04
MAINTAINER Amanda Cooksey
LABEL Description="miRDeep2"


# Install all the updates and download dependencies
RUN apt-get update && \
    apt-get install -y \
    apt-utils \
    git \
    wget \
    nano \
    locales \
    bzip2 \
    gzip \
    libpadwalker-perl \
    make \
    build-essential

RUN cpan PDF::API2 IO::String Sub::Uplevel Devel::Cycle Font::TTF

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.0.5-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh


# give write permissions to conda folder
RUN chmod 777 -R /opt

ENV PATH=$PATH:/opt/conda/bin

RUN conda config --add channels bioconda

RUN conda upgrade conda

# add blast 2.7.1
RUN conda install -c conda-forge -c bioconda mirdeep2==2.0.1.2


RUN export LC_ALL=en_US.UTF-8
RUN export LANG=en_US.UTF-8
RUN locale-gen en_US.UTF-8

RUN mkdir /opt/conda/bin/indexes

ADD Rfam_index*ebwt /opt/conda/bin/indexes/

RUN mkdir /work-dir

WORKDIR /work-dir
