# LICENCE: Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Abel García Dorta <mercuriete@gmail.com> 

FROM codenvy/ubuntu_jre

MAINTAINER mercuriete@gmail.com

USER root
RUN echo "deb [arch=amd64] http://apt-mo.trafficmanager.net/repos/dotnet/ trusty main" > /etc/apt/sources.list.d/dotnetdev.list && \
    apt-key adv --keyserver apt-mo.trafficmanager.net --recv-keys 417A0893 &&\
    apt-get update && \
    apt-get install dotnet-dev-1.0.0-preview1-002702 -y && \
    apt-get clean && \
    apt-get -y autoremove \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*
ENV LANG C.UTF-8
USER user
EXPOSE 22 4403
WORKDIR /projects
CMD sudo /usr/sbin/sshd -D && \
    tail -f /dev/null
