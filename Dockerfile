
FROM nimbix/ubuntu-desktop:trusty
MAINTAINER stephen.fox@nimbix.net

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y make && \ 
    apt-get install -y gfortran && \

    apt-get -y install software-properties-common python-software-properties && \

    wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add - && \
    wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list && \
    apt-get update && \
    apt-get install s3cmd && \
    wget -O /tmp/octave-4.2.2.tar.gz ftp://ftp.gnu.org/gnu/octave/octave-4.2.2.tar.gz && \
    cd /tmp && \
    tar -xvf octave-4.2.2.tar.gz && \
    cd octave-4.2.2 && \
    ./configure && \
    make && \
    make install 

WORKDIR /home/nimbix
RUN /usr/bin/wget https://s3.amazonaws.com/yb-lab-cfg/admin/yb-admin.NIMBIX.x86_64.tar \
&& tar xvf yb-admin.NIMBIX.x86_64.tar -C /usr/bin \
&& apt-get install -y tcl \
&& apt-get install -y git 


ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
ADD ./NAE/AppDef.json /etc/NAE/AppDef.json

CMD /usr/local/scripts/start.sh
CMD /usr/local/scripts/update_drivers.sh
