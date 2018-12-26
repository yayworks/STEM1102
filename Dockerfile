FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04
LABEL maintainer="Nimbix, Inc."

# Update SERIAL_NUMBER to force rebuild of all layers (don't use cached layers)
ARG SERIAL_NUMBER
ENV SERIAL_NUMBER ${SERIAL_NUMBER:-20181226.1130}

ARG GIT_BRANCH
ENV GIT_BRANCH ${GIT_BRANCH:-master}

RUN apt-get -y update && \
    apt-get -y install curl && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
        | bash -s -- --setup-nimbix-desktop --image-common-branch $GIT_BRANCH

# Install CUDA samples
RUN apt-get -y install cuda-samples-9-1 && apt-get clean

# Fix VirtualGL for sudo
RUN chmod u+s /usr/lib/libdlfaker.so /usr/lib/libvglfaker.so

# Metadata
COPY NAE/AppDef.json /etc/NAE/AppDef.json
RUN curl --fail -X POST -d @/etc/NAE/AppDef.json https://api.jarvice.com/jarvice/validate

# Install requirements (gcc & g++)
RUN apt-get update && apt-get install -y --no-install-recommends \
    software-properties-common python-software-properties \
    build-essential \
    awscli \
    expect \
    curl \
    git \
    make \
    tcl \
    wget \
    libibverbs-dev \
    libibverbs1 \
    librdmacm1 \
    librdmacm-dev \
    rdmacm-utils \
    libibmad-dev \
    libibmad5 \
    byacc \
    libibumad-dev \
    libibumad3 \
    flex \
    gfortran && \
    apt-get install -y python3.4 && \
    apt-get install -y python3-pip && \
    apt-get install -y python-qt4 && \ 
    apt-get install -y nodejs-legacy && \
    apt-get install -y npm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# nvidia-docker 1.0
LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

ENV PATH            /usr/local/nvidia/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64:${LD_LIBRARY_PATH}

# nvidia-docker 2.0
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

## Install YayBench stuff
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add - 
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list 
RUN apt-get update 
RUN apt-get install -y s3cmd 

ADD ./yb-sw-config.NIMBIX.x8664.turbotensor.sh /tmp/yb-sw-config.NIMBIX.x8664.turbotensor.sh
RUN /bin/bash -x /tmp/yb-sw-config.NIMBIX.x8664.turbotensor.sh 

WORKDIR /home/nimbix
RUN /usr/bin/wget https://s3.amazonaws.com/yb-lab-cfg/admin/yb-admin.NIMBIX.x86_64.tar && \
    tar xvf yb-admin.NIMBIX.x86_64.tar -C /usr/bin 

ADD ./jupyterhub_config.py /usr/local
ADD ./wetty.tar.gz /usr/local
ADD ./config.sh /usr/local/config.sh
ADD ./start.sh /usr/local/start.sh
ADD ./setup.x /usr/local/setup.x
ADD ./jpy_lab_start.sh /usr/local/jpy_lab_start.sh
RUN chmod +x /usr/local/config.sh && chown nimbix.nimbix /usr/local/config.sh && \
    chmod +x /usr/local/start.sh && chown nimbix.nimbix /usr/local/start.sh && \
    chmod +x /usr/local/setup.x && chown nimbix.nimbix /usr/local/setup.x && \
    chmod +x /usr/local/jpy_lab_start.sh 
 
    
RUN sudo apt-get install -y r-base && \
    sudo apt-get install -y r-base-dev && \
    sudo apt-get install -y gdebi-core 

RUN /usr/bin/wget https://download1.rstudio.org/rstudio-xenial-1.1.456-amd64.deb && \
    sudo apt-get -y install libjpeg62 && \
    sudo dpkg -i rstudio-xenial-1.1.456-amd64.deb && \
    rm rstudio-xenial-1.1.456-amd64.deb
    
RUN cat /etc/apt/sources.list | grep deb-src && \
    sudo sed -i~orig -e 's/# deb-src/deb-src/' /etc/apt/sources.list && \
    sudo apt-get update

RUN echo " " | sudo apt-add-repository ppa:octave/stable && \
    sudo apt-get update && \
    sudo apt-get install -y octave && \
    sudo apt-get build-dep -y octave && \
    sudo /usr/local/anaconda3/bin/conda config --add channels conda-forge && \
    echo "Y" | sudo /usr/local/anaconda3/bin/conda install -c conda-forge octave_kernel
    
RUN sudo apt-get install -y maxima && \
    sudo apt-get update && \
    sudo apt-get install -y wxmaxima
    
RUN sudo /usr/local/anaconda3/bin/pip install jupyter_c_kernel && \
    sudo /usr/local/anaconda3/bin/install_c_kernel
    
RUN /usr/local/anaconda3/bin/conda create -n fenicsproject -c conda-forge python=3.6 fenics mshr ipython && \
    sudo apt-get -y install paraview

RUN wget -O/tmp/gmsh-git-Linux64.tgz http://gmsh.info//bin/Linux/gmsh-git-Linux64.tgz && \
    cd /tmp && \
    sudo tar xvfz gmsh-git-Linux64.tgz && \
    sudo cp /tmp/gmsh-git-Linux64/bin/gmsh /usr/local/bin && \
    sudo mkdir /usr/share/gmsh && \
    sudo cp -r /tmp/gmsh-git-Linux64/share /usr/share/gmsh


RUN mkdir -p /opt/images && \
    mkdir -p /opt/icons

ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
ADD ./NAE/screenshot.png /etc/NAE/screenshot.png
ADD ./Wallpaper-yaybench_1280x720.png /opt/images/Wallpaper.png
ADD ./yaymark_57x57.png /opt/icons/yaybench.png
ADD ./xfce4-desktop.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ADD ./xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

CMD /usr/local/scripts/start.sh
CMD /usr/local/scripts/update_drivers.sh

ADD ./install_cmake.sh /usr/local/install_cmake.sh
RUN  chmod +x          /usr/local/install_cmake.sh
RUN /bin/bash -x       /usr/local/install_cmake.sh

RUN echo 'export PATH=/usr/local/bin:/usr/local/cuda/bin:/usr/local/anaconda3/envs/fenicsproject/bin:/usr/local/anaconda3/bin:$PATH' >> /etc/skel/.bashrc \
&&  echo 'export PYTHONPATH=/usr/local/anaconda3/envs/fenicsproject/lib:/usr/local/anaconda3/envs/fenicsproject/lib/python3.6:/usr/local/anaconda3/envs/fenicsproject/lib/python3.6/site-packages/:/usr/local/anaconda3/envs/fenicsproject/lib/python3.6/site-packages/matplotlib:$PYTHONPATH' >> /etc/skel/.bashrc


# Expose port 22 for local JARVICE emulation in docker
EXPOSE 22

# for standalone use
EXPOSE 5901
EXPOSE 443




