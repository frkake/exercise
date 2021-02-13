# FROM pytorch/pytorch:1.2-cuda10.0-cudnn7-devel
FROM nvidia/cuda:10.2-cudnn8-devel-ubuntu18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt install --yes build-essential \
                         software-properties-common \
                         ubuntu-drivers-common \
                         wget \
                         unzip \
                         cmake \
                         ffmpeg \
                         pkg-config \
                         hdf5-tools \
                         hdf5-helpers \
                         libhdf5-dev \
                         libhdf5-doc \
                         libhdf5-serial-dev \
                         libgoogle-glog-dev \
                         tmux \
                         imagemagick \
                         tree

ENV PYVER 3.8
WORKDIR /opt
RUN wget https://repo.continuum.io/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh
RUN bash Miniconda*.sh -b -p /opt/conda/ \
    && rm /opt/Miniconda*.sh
ENV PATH /opt/conda/bin:$PATH
RUN conda install --yes python=${PYVER} pip
RUN conda clean --yes --all

RUN pip install numpy \
                matplotlib \
                h5py \
                natsort \
                imageio \
                scipy \
                tqdm \
                future \
                ipython \
                jupyterlab \
                click \
                pandas \
                Pillow \
                seaborn

RUN pip install crc32c \
                soundfile \
                opencv-python \
                opencv-contrib-python \
                torch \
                torchvision \
                tensorboardX \
                scikit-image \
                scikit-learn

RUN pip install icecream \
                loguru \
                mlflow \
                hydra

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LC_CTYPE=C.UTF-8

WORKDIR /workspace