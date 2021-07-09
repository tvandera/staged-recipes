#!/bin/sh

mkdir build
cd build

# ArrayFire 3.7.3 has problems compiling with std=c++17
# but the conda-forge compilers set this flag --> revert
CXXFLAGS="$(echo $CXXFLAGS |sed -e 's/-std=c++17/-std=c++14/g')"
DEBUG_CXXFLAGS="$(echo $DEBUG_CXXFLAGS |sed -e 's/-std=c++17/-std=c++14/g')"

cmake \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_RPATH='$ORIGIN/../lib' \
    -DAF_BUILD_CPU=${ENABLE_CPU} \
    -DUSE_CPU_MKL=ON \
    -DAF_BUILD_CUDA=${ENABLE_CUDA} \
    -DAF_WITH_CUDNN=ON \
    -DAF_BUILD_OPENCL=OFF \
    -DAF_BUILD_UNIFIED=OFF \
    -DAF_BUILD_EXAMPLES=OFF \
    -DBUILD_TESTING=OFF \
    ${SRC_DIR}

make -j$CPU_COUNT
make install
# rm -rf $PREFIX/share/ArrayFire/examples
rm -rf $PREFIX/LICENSES
