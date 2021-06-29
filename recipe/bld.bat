mkdir build
if errorlevel 1 exit 1

cd build
if errorlevel 1 exit 1

cmake.exe ^
    -G "%CMAKE_GENERATOR%" ^
    %CMAKE_ARGS% ^
    -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
    -DAF_BUILD_CPU=%ENABLE_CPU% ^
    -DUSE_CPU_MKL=ON ^
    -DMKL_ThreadingLibrary_LINK_LIBRARY=" " ^
    -DAF_BUILD_CUDA=%ENABLE_CUDA% ^
    -DAF_WITH_CUDNN=ON ^
    -DAF_BUILD_OPENCL=OFF ^
    -DAF_BUILD_UNIFIED=OFF ^
    -DAF_BUILD_EXAMPLES=OFF ^
    -DBUILD_TESTING=OFF ^
    -Wno-dev ^
    %SRC_DIR%
if errorlevel 1 exit /b 1

cmake.exe --build . --config Release
if errorlevel 1 exit /b 1

cmake.exe --build . --config Release --target install
if errorlevel 1 exit /b 1
