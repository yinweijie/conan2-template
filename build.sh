#!/bin/bash

set -e

# ref. https://www.yuque.com/yinweijie/gr78mf/fwvaoiim6xnpsxhg?singleDoc# 《conan模板》

# 方法一
# conan install . --output-folder=build --build=missing
# cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release
# cmake --build build

mode=${1:-release}

if [ "$mode" == "release" ]; then
    echo "Building in release mode..."
    # 方法二，release mode
    conan install . --build=missing
    cmake --list-presets
    cmake --preset=conan-release
    cmake --build --preset=conan-release
    echo '------ output ------'
    ./build/Release/compressor
    echo '------ sync compile_commands.json ------'
    # 复制 compile_commands.json 到 build 目录
    rsync -avh ./build/Release/compile_commands.json ./build/
else
    echo "Building in debug mode..."
    ## > conan config home
    ## > cp /home/ywj22/.conan2/profiles/default /home/ywj22/.conan2/profiles/debug
    ## > code /home/ywj22/.conan2/profiles/debug
    ## 
    ## build_type=Debug
    ## 
    # 方法二，debug mode
    conan install . --build=missing -s="build_type=Debug"
    # 上面这行等价于下面这行(注意需要生成debug profile)
    # conan install . --build=missing --profile=debug
    cmake --preset=conan-debug -DCMAKE_BUILD_TYPE=Debug
    cmake --build --preset=conan-debug 
    echo '------ output ------'
    ./build/Debug/compressor
    echo '------ sync compile_commands.json ------'
    # 复制 compile_commands.json 到 build 目录
    rsync -avh ./build/Debug/compile_commands.json ./build/
fi

