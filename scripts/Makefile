SPECIFIC_NODE_ARG ?= "-w gpu-0-0 "

THIS_DIR ?= /home/czavou01/DeepSDF

conda-turing1:
	conda create -n deepsdf python=3.6
	conda activate deepsdf
	conda install pytorch==1.6.0 torchvision==0.7.0 cudatoolkit=10.1 -c pytorch
	conda install scikit-image
	conda install -c conda-forge trimesh

install-dependencies-turing1:
	git clone --recursive https://github.com/christinazavou/DeepSDF.git
	git checkout -b experimental
	git pull origin experimental
	module add CMake/3.18.4-GCCcore-10.2.0
	cd $(THIS_DIR)/third-party/ && wget https://github.com/CLIUtils/CLI11/archive/refs/tags/v2.0.0.tar.gz && tar -xvf v2.0.0.tar.gz
	cd $(THIS_DIR)/third-party/ && wget https://gitlab.com/libeigen/eigen/-/archive/3.4.0/eigen-3.4.0.tar.gz && tar -xvf eigen-3.4.0.tar.gz
	cd $(THIS_DIR)/third-party/ && git clone --recursive https://github.com/jlblancoc/nanoflann.git
	cd $(THIS_DIR)/third-party/ && git clone https://github.com/stevenlovegrove/Pangolin.git
	module add Mesa/20.2.1-GCCcore-10.2.0
	module add libGLU/9.0.1-GCCcore-10.2.0
	module add glew/2.1.0-GCCcore-10.2.0
	mkdir $(THIS_DIR)/third-party/Pangolin/build && cd $(THIS_DIR)/third-party/Pangolin/build && cmake .. && make
	mkdir $(THIS_DIR)/third-party/include
	cp -r $(THIS_DIR)/third-party/CLI11-2.0.0/include/* include/
	mkdir $(THIS_DIR)/third-party/include/nanoflann && cp $(THIS_DIR)/third-party/nanoflann/include/* $(THIS_DIR)/third-party/include/nanoflann/
	cp -r $(THIS_DIR)/third-party/eigen-3.4.0/Eigen/ include/

install-turing1:
	cd $(THIS_DIR) && mkdir build && cd build && cmake .. && make -j

#or:
#module add Eigen/3.3.7-GCCcore-9.3.0

preprocess-all-parallel-turing1:
	sbatch --job-name=prepsdf $(SPECIFIC_NODE_ARG) preprocess_all_parallel.sh
