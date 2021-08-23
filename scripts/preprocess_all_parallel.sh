#!/bin/bash
#SBATCH -o %j.out
#SBATCH -e %j.err
#SBATCH --nodes=1
#SBATCH --partition=GPU

SOURCE_DIR=${SOURCE_DIR:-/home/czavou01/DeepSDF/}
DATA_DIR=${DATA_DIR:-/home/czavou01/deepsdf-logs/data/}
SOURCE_DATA=${SOURCE_DATA:-/home/czavou01/ShapeNetCore.v1}

PY_EXE=${PY_EXE:-/home/czavou01/miniconda3/envs/deepsdf/bin/python}

echo "SOURCE_DIR: ${SOURCE_DIR}"
echo "PY_EXE: ${PY_EXE}"

export CUDA_VISIBLE_DEVICES="0,1,2"

preprocess_train_sdf(){
  exho "preprocess_train_sdf"
  out_file=preprocess_train_sdf.out
  err_file=preprocess_train_sdf.err
  export SOURCE_DIR=${SOURCE_DIR} \
    && export DATA_DIR=${DATA_DIR} \
    && export SOURCE_DATA=${SOURCE_DATA} \
    && export TEST=0 \
    && sh ./preprocess_data.sh > $out_file 2>$err_file
}
preprocess_test_sdf(){
  echo "preprocess_test_sdf"
  out_file=preprocess_test_sdf.out
  err_file=preprocess_test_sdf.err
  export SOURCE_DIR=${SOURCE_DIR} \
    && export DATA_DIR=${DATA_DIR} \
    && export SOURCE_DATA=${SOURCE_DATA} \
    && export TEST=1 \
    && sh ./preprocess_data.sh > $out_file 2>$err_file
}
preprocess_test_surface(){
  echo "preprocess_test_surface"
  out_file=preprocess_test_surface.out
  err_file=preprocess_test_surface.err
  export SOURCE_DIR=${SOURCE_DIR} \
    && export DATA_DIR=${DATA_DIR} \
    && export SOURCE_DATA=${SOURCE_DATA} \
    && export TEST=2 \
    && sh ./preprocess_data.sh > $out_file 2>$err_file
}

processes=()
preprocess_train_sdf &
current_process=$!
processes+=("$current_process")
preprocess_test_sdf &
current_process=$!
processes+=("$current_process")
preprocess_test_surface &
current_process=$!
processes+=("$current_process")

for pid in ${processes[*]}; do
  echo "pid: $pid"
  wait $pid
done

