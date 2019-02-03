FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

VOLUME /build

LABEL opencv.version="4.0.1"
LABEL maintainer="Robert F. Dickerson"

ENV OPENCV_VERSION 4.0.1
ENV BUILD_EXAMPLES OFF
ENV BUILD_TESTS OFF
ENV OPENCV_ENABLE_NONFREE ON

RUN apt-get update && apt-get install -y \
    build-essential \
    ccache \
    checkinstall \
    cmake \
    curl \
    gfortran \
    git \
    libatlas-base-dev \
    libavcodec-dev \
    libavformat-dev \
    libavresample-dev \
    libdc1394-22-dev \
    libeigen3-dev \
    libgstreamer-plugins-good1.0-dev \
    libgtk2.0-dev \
    libhdf5-dev \
    libjpeg-dev \
    liblapack-dev \
    libmp3lame-dev \
    libopenblas-dev \
    libopenblas-dev \
    libpng-dev \
    libprotobuf-dev \
    libswscale-dev \
    libtbb-dev \
    libtbb2 \
    libv4l-dev \
    libvorbis-dev \
    libx264-dev \
    libxine2-dev \
    libxvidcore-dev \
    protobuf-compiler \
    python2.7-dev \
    python3 \
    python3-pip \
    v4l-utils \
    x264 \
    yasm \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Setup the Python 3 virtual environment
RUN pip3 install \
    numpy \
    scipy \
    scikit-image \
    scikit-learn \
    flake8 \
    pylint

RUN git clone https://github.com/opencv/opencv.git --branch ${OPENCV_VERSION}

# OpenCV contrib modules
RUN git clone https://github.com/opencv/opencv_contrib --branch ${OPENCV_VERSION}

WORKDIR /build

COPY compile.sh /

CMD /compile.sh