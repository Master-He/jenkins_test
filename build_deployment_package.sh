#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Please input the path(with package name, e.g. /release/hyperminer_v1.0.tar.gz) where the package store."
    exit
fi
file=$1

export PATH="/root/anaconda3/bin:$PATH"
conda create -y -n hm python=3.5
source activate hm
pip install numpy==1.14.5

source .env
export HYPERMINER_VERSION=${HYPERMINER_VERSION}
export MLSTUDIOSDK_PACKAGE_DATA=${MLSTUDIOSDK_PACKAGE_DATA}
cd hyperminer/mlstudiosdk
python3 setup.py clean --all
python3 setup.py bdist_wheel

source deactivate
conda remove -y -n hm --all

cp dist/*.whl ./
cp dist/*.whl ../../job_cpu/
cp dist/*.whl ../../job_gpu/
cp dist/*.whl ../../scheduler/
cp dist/*.whl ../../jupyter_gpu/
cp dist/*.whl ../../jupyter_cpu/
cd ../../

if [ -d "build" ]; then
    rm -rf build
fi

mkdir build
cp docker-compose.yml install.sh .env build/
mkdir build/hyperminer build/scheduler build/jupyter_cpu build/jupyter_gpu build/job_cpu build/job_gpu


docker-compose build hyperminer scheduler jupyter_cpu jupyter_gpu job_cpu job_gpu


echo "Packing docker images"
docker save -o build/hyperminer_leap_${HYPERMINER_VERSION}.tar hyperminer_leap:${HYPERMINER_VERSION}

docker save -o build/hyperminer_scheduler_${HYPERMINER_VERSION}.tar hyperminer_scheduler:${HYPERMINER_VERSION}

docker save -o build/hyperminer_jupyter_cpu_${HYPERMINER_VERSION}.tar hyperminer_jupyter_cpu:${HYPERMINER_VERSION}

docker save -o build/hyperminer_jupyter_gpu_${HYPERMINER_VERSION}.tar hyperminer_jupyter_gpu:${HYPERMINER_VERSION}

docker save -o build/hyperminer_job_cpu_${HYPERMINER_VERSION}.tar hyperminer_job_cpu:${HYPERMINER_VERSION}

docker save -o build/hyperminer_job_gpu_${HYPERMINER_VERSION}.tar hyperminer_job_gpu:${HYPERMINER_VERSION}


packagepath=$(readlink -f "$PWD/$file")
cd build
tar -czvf ${packagepath} .
cd ..
