FROM pytorch/pytorch:1.7.0-cuda11.0-cudnn8-devel

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
                         tree \
                         sudo

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
                scikit-image \
                scikit-learn

RUN pip install icecream \
                loguru \
                mlflow \
                hydra

# setting USER group number
ENV USER developer
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/${USER}
RUN chmod u+s /usr/sbin/useradd \
   && chmod u+s /usr/sbin/groupadd
ENV HOME /home/${USER}
ENV SHELL /bin/bash
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV TERM xterm-256color
RUN echo 'Defaults visiblepw' >> /etc/sudoers
RUN echo 'USER ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER ${USER}

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]

WORKDIR /workspace

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV LC_CTYPE=C.UTF-8

WORKDIR /workspace