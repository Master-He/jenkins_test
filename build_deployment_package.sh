#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Please input the path(with package name, e.g. /release/hyperminer_v1.0.tar.gz) where the package store."
    exit
fi
file=$1

pip list
export PATH="/root/anaconda3/bin:$PATH"
conda create -y -n hm python=3.5
source activate hm
pip install numpy==1.14.5
pip list
source .env
export HYPERMINER_VERSION=${HYPERMINER_VERSION}
export MLSTUDIOSDK_PACKAGE_DATA=${MLSTUDIOSDK_PACKAGE_DATA}
env
