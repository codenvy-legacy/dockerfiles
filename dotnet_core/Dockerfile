# LICENCE: Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Abel García Dorta <mercuriete@gmail.com> 

FROM codenvy/ubuntu_jre

MAINTAINER mercuriete@gmail.com

RUN echo "deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/dotnet/ trusty main" | sudo tee --append /etc/apt/sources.list.d/dotnetdev.list && \
    sudo apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 &&\
    sudo apt-get update && \
    sudo apt-get install dotnet-dev-1.0.0-preview1-002702 -y && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/*
ENV LANG C.UTF-8
EXPOSE 5000
WORKDIR /projects
CMD tail -f /dev/null

