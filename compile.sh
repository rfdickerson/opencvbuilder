cmake \
    -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D ENABLE_CXX11=ON \
    -D INSTALL_PYTHON_EXAMPLES=ON \
    -D WITH_CUDA=ON \
    -D WITH_TBB=ON \
    -D ENABLE_FAST_MATH=ON \
    -D CUDA_FAST_MATH=ON \
    -D WITH_CUBLAS=ON \
    -D INSTALL_C_EXAMPLES=${BUILD_EXAMPLES}} \
    -D OPENCV_ENABLE_NONFREE=${OPENCV_ENABLE_NONFREE} \
    -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
    -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
    -D BUILD_EXAMPLES=${BUILD_EXAMPLES} \
    -D BUILD_TESTS=${BUILD_TESTS} \
    /opencv

make -j$(nproc)

checkinstall \
    --default \
    --type debian \
    --install=no \
    --pkgname opencv-cuda \
    --pkgversion "4.0.1" \
    --pkglicense BSD \
    --deldoc --deldesc --delspec \
    --requires "" \
    --pakdir /package  \
    --maintainer "Robert F Dickerson" \
    --provides opencv \
    --addso \
    --autodoinst