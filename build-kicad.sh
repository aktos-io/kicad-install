#!/bin/bash 

DIR=$(dirname "$(readlink -f "$0")")
source $DIR/conf.sh

if [[ ! -d $ROOT ]]; then 
    echo "$ROOT is not found, follow the README"
    exit
fi

sudo apt-get install libwxgtk3.0-0v5 libglew-dev libcairo2-dev libbz2-dev \
	libwxgtk3.0-dev libcurl4-openssl-dev\
        doxygen libssl-dev libglm-dev\
        libboost-dev libboost-thread-dev libboost-context-dev \
        libboost-filesystem-dev libboost-iostreams-dev \
        libboost-locale-dev libboost-program-options-dev \
        libboost-test-dev \
        swig python-wxgtk3.0* \
        cmake


cd $ROOT

git clean -f -d

mkdir -p $BUILD_DIR
cd $BUILD_DIR

cmake \
  -DCMAKE_PREFIX_PATH=$KICAD_INSTALL_PREFIX \
  -DCMAKE_INSTALL_PREFIX=$KICAD_INSTALL_PREFIX \
  -DDEFAULT_INSTALL_PATH=$KICAD_INSTALL_PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DKICAD_SCRIPTING=ON \
  -DKICAD_SCRIPTING_MODULES=ON \
  -DKICAD_SCRIPTING_WXPYTHON=ON \
  -H"../../" \
  -B"$BUILD_DIR"

make -j 4
