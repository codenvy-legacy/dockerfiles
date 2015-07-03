FROM codenvy/shellinabox

RUN wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- \
    "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.tar.gz" | sudo tar -zx -C /opt/

ENV JAVA_HOME /opt/jdk1.8.0_45
RUN echo "export JAVA_HOME=$JAVA_HOME" >> /home/user/.bashrc
ENV PATH $JAVA_HOME/bin:$PATH
RUN echo "export PATH=$PATH" >> /home/user/.bashrc
