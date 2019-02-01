FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu18.04

LABEL opencv.version="4.0.1"
ENV OPENCV_VERSION 4.0.1

RUN apt-get update && apt-get install -y \
    build-essential \
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
    libgtk2.0-dev \
    libhdf5-dev \
    libjpeg-dev \
    liblapack-dev \
    libmp3lame-dev \
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

RUN mkdir build

WORKDIR /build

RUN cmake \
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D WITH_CUDA=ON \
        -D WITH_TBB=ON \
        -D ENABLE_FAST_MATH=1 \
        -D CUDA_FAST_MATH=1 \
        -D WITH_CUBLAS=1 \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_ENABLE_NONFREE=ON \
        -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
        -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
        -D BUILD_EXAMPLES=ON \
        -D BUILD_TESTS=OFF \
        /opencv

CMD make -j$(nproc)