
FROM nimbix/app-cuda-ubuntu
MAINTAINER Nimbix, Inc.

RUN apt-get update && \
    apt-get -y install software-properties-common python-software-properties && \
    apt-get install -y \
    build-essential \
    awscli \
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

RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add - 
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list 
RUN apt-get update 
RUN apt-get install -y s3cmd 

WORKDIR /home/nimbix
RUN /usr/bin/wget https://s3.amazonaws.com/yb-lab-cfg/admin/yb-admin.NIMBIX.x86_64.tar  && \
    tar xvf yb-admin.NIMBIX.x86_64.tar -C /usr/bin && \
    apt-add-repository ppa:octave/stable && \
    apt-get update && \
    apt-get install -y octave && \
    apt-get build-dep -y octave 

RUN sudo apt-get install -y r-base && \
    sudo apt-get install -y r-base-dev && \
    sudo apt-get install -y gdebi-core 
RUN /usr/bin/wget https://download2.rstudio.org/rstudio-server-1.1.442-amd64.deb && \
    echo "y" |sudo gdebi rstudio-server-1.1.442-amd64.deb && \
    echo "auth-minimum-user-id=500" >> /etc/rstudio/rserver.conf && \
    rm rstudio-server-1.1.442-amd64.deb 
    
RUN sudo apt-get update && \
    sudo apt-get install -y scilab 

RUN mkdir -p /opt/images && \
    mkdir -p /opt/icons


ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
ADD ./NAE/AppDef.json /etc/NAE/AppDef.json
ADD ./NAE/screenshot.png /etc/NAE/screenshot.png
ADD ./Wallpaper-yaybench_1280x720.png /opt/images/Wallpaper.png
ADD ./yaymark_57x57.png /opt/icons/yaybench.png
ADD ./xfce4-desktop.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml
ADD ./xfce4-panel.xml /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

CMD /usr/local/scripts/start.sh
CMD /usr/local/scripts/update_drivers.sh
