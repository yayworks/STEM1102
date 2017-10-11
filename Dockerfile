
FROM nimbix/ubuntu-desktop:trusty
MAINTAINER stephen.fox@nimbix.net

RUN apt-get update && apt-get install -y curl
RUN apt-get -y install software-properties-common python-software-properties
#RUN apt-get -y install qt5-default

RUN add-apt-repository http://dl.openfoam.org/ubuntu
RUN sh -c "wget -O - http://dl.openfoam.org/gpg.key | apt-key add -"
RUN apt-get update
RUN apt-get -y install apt-transport-https
RUN apt-get -y install openfoam5

RUN echo 'source /opt/openfoam5/etc/bashrc' >> /etc/skel/.bashrc

#RUN mkdir -p /usr/local/src

#WORKDIR /usr/local/src

#RUN wget https://s3.amazonaws.com/yb-lab-cfg/ParaView-5.1.2-Qt4-OpenGL2-MPI-Linux-64bit.tar.gz
#RUN tar xvf "ParaView-5.1.2-Qt4-OpenGL2-MPI-Linux-64bit.tar.gz"

#RUN mv /usr/local/src/ParaView-5.1.2-Qt4-OpenGL2-MPI-Linux-64bit /usr/local/ParaView-5.1.2
#RUN rm "/usr/local/src/ParaView-5.1.2-Qt4-OpenGL2-MPI-Linux-64bit.tar.gz"

#RUN wget https://s3.amazonaws.com/yb-lab-cfg/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit.tar.gz
#RUN tar xvf "ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit.tar.gz"

#RUN mv /usr/local/src/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit /usr/local/ParaView-5.4.1
#RUN rm /usr/local/src/ParaView-5.4.1-Qt5-OpenGL2-MPI-Linux-64bit.tar.gz



ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
#ADD ./NAE/AppDef.png /etc/NAE/AppDef.png
ADD ./NAE/AppDef.json /etc/NAE/AppDef.json
#COPY ./NAE/screenshot.png /etc/NAE/screenshot.png

#CMD /usr/local/scripts/start.sh
CMD /usr/local/scripts/update_drivers.sh
