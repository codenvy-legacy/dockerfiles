FROM codenvy/jdk7_vnc
RUN mkdir /home/user/app
WORKDIR /home/user/app
ADD $app$ /home/user/$app$
RUN unzip -q /home/user/$app$ -d /home/user/app
