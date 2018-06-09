
#!/bin/bash


export MPI_HOME=/usr
export LD_PRELOAD=/usr/lib/libmpi_cxx.so
export PYTHONHOME=/usr/local/py_distro

#$PYTHONHOME/bin/python /home/nimbix/ptf_examples/MNIST/tf_lenet3.py --train_batch  64  --iterations 1000


numnodes=`cat /etc/JARVICE/nodes|wc -l`

mpirun -np $numnodes --map-by node --hostfile /etc/JARVICE/nodes /usr/local/setup.x
