
FROM nimbix/ubuntu-desktop:trusty
MAINTAINER stephen.fox@nimbix.net

RUN apt-get update && \
    apt-get install -y curl && \
    apt-get install -y make && \ 
    apt-get install -y gfortran 



    


# ADD ./scripts /usr/local/scripts

# Add PushToCompute Work Flow Metadata
# ADD ./NAE/nvidia.cfg /etc/NAE/nvidia.cfg
# ADD ./NAE/AppDef.json /etc/NAE/AppDef.json

#CMD /usr/local/scripts/start.sh
# CMD /usr/local/scripts/update_drivers.sh
