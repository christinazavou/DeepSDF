#!/bin/bash


PY_EXE=${PY_EXE:-/home/czavou01/miniconda3/envs/deepsdf/bin/python}
SOURCE_DIR=${SOURCE_DIR:-/home/czavou01/DeepSDF/}
DATA_DIR=${DATA_DIR:-/home/czavou01/deepsdf-logs/data/}
SOURCE_DATA=${SOURCE_DATA:-/home/czavou01/ShapeNetCore.v1}
TEST=${TEST:-0}

args=""
args="$args --data_dir ${DATA_DIR}"
args="$args --source ${SOURCE_DATA}"
args="$args --name Shapenetv1"
args="$args --skip"

if [[ "$TEST" == 0 ]]; then
  args="$args --split examples/splits/sv2_chairs_train.json --log /home/czavou01/deepsdf-logs/preprocess_train_sdf.log"
elif [[ "$TEST" == 1 ]]; then
  args="$args --split examples/splits/sv2_chairs_test.json --log /home/czavou01/deepsdf-logs/preprocess_test_sdf.log --test"
else
  args="$args --split examples/splits/sv2_chairs_test.json --log /home/czavou01/deepsdf-logs/preprocess_test_surface.log --surface"

echo "cd ${SOURCE_DIR} && ${PY_EXE} preprocess_data.py $args"
cd ${SOURCE_DIR} && ${PY_EXE} preprocess_data.py $args
