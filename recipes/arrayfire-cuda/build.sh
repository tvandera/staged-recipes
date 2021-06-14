#!/bin/sh


# sed -i -e 's/CMAKE_CXX_STANDARD 14/CMAKE_CXX_STANDARD 17/g' CMakeModules/InternalUtils.cmake
# sed -i -e 's/=c++14/=c++17/g' CMakeModules/InternalUtils.cmake

mkdir build && cd build

CXXFLAGS="$(echo $CXXFLAGS |sed -e 's/-std=c++17/-std=c++14/g')"
DEBUG_CXXFLAGS="$(echo $DEBUG_CXXFLAGS |sed -e 's/-std=c++17/-std=c++14/g')"

cmake \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_RPATH='$ORIGIN/../lib' \
    -DAF_BUILD_CPU=OFF \
    -DAF_BUILD_CUDA=ON \
    -DAF_BUILD_OPENCL=OFF \
    -DAF_BUILD_UNIFIED=OFF \
    -DAF_BUILD_EXAMPLES=OFF \
    -DBUILD_TESTING=OFF \
    ..

make -j$CPU_COUNT
make install
rm -rf $PREFIX/share/ArrayFire/examples
rm -rf $PREFIX/LICENSES
