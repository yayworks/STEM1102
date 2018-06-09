
#!/bin/bash
####################################################################################################
#                                                                                                  #
# yb-sw-config.NIMBIX.x8664.turbotensor.sh - Software installs & configuration for Ubuntu TF Lab  #
#                                                                                                  #
# Copyright (C) 2017 Yayworks, Inc. - All Rights Reserved                                          #
#                                                                                                  #
# Last revised 06/08/2018                                                                          #
#                                                                                                  #
####################################################################################################


wget https://repo.continuum.io/archive/Anaconda3-5.2.0-Linux-x86_64.sh

(
sudo bash Anaconda3-5.2.0-Linux-x86_64.sh <<EOF

yes
/usr/local/anaconda3
yes
no

EOF

) > com.out

rm com.out

sudo /usr/local/anaconda3/bin/conda install -c conda-forge jupyterlab <<EOF
y
EOF

###This finally did work

sudo /usr/local/anaconda3/bin/conda create -n tensorflow python=3.6 <<EOF
y
EOF

source /usr/local/anaconda3/bin/activate tensorflow

sudo /usr/local/anaconda3/bin/conda install -c conda-forge tensorflow <<EOF
y
EOF

sudo /usr/local/anaconda3/envs/tensorflow/bin/pip install --upgrade prettytensor
sudo /usr/local/anaconda3/envs/tensorflow/bin/pip install --upgrade gym

##cd /tmp
##wget https://s3.amazonaws.com/yb-lab-cfg/pnnl_tfg_v2.tar.gz
##tar xvfpz pnnl_tfg_v2.tar.gz
###WORKDIR /root/cpu/py3.x

##export MPI_HOME=/usr
##export CUDA_HOME=/usr/local/cuda
##export CUDNN_HOME=/usr/local/cuda

##export PNETCDF_INSTALL_DIR=parallel-netcdf-1.7.0
##export TF_INSTALL_DIR=/tmp/gpu/py3.x
##export FAKE_SYSTEM_LIBS=$TF_INSTALL_DIR/fakeRoot/

##cd /tmp/gpu/py3.x
##source /tmp/gpu/py3.x/setAlias.sh
##source /tmp/gpu/py3.x/install_mpi_tf_cuda8_0.sh





exit 0



