
#!/bin/sh

wget https://www.open-mpi.org/software/ompi/v2.0/downloads/openmpi-${MPI_VERSION}.tar.bz2
tar xvf openmpi-${MPI_VERSION}.tar.bz2
cd /tmp/openmpi-${MPI_VERSION} && \
    ./configure --with-cuda=/usr/local/cuda  --enable-mpi-cxx -prefix=/usr && \
    make -j4 && \
    make install
cd /tmp && \
    rm -rf /tmp/openmpi-${MPI_VERSION}

##echo 'LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib' >> /etc/skel/.bashrc
##echo 'PATH=${PATH}:/usr/local/bin' >> /etc/skel/.bashrc
