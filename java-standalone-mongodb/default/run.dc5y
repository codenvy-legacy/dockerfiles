FROM codenvy/jdk7_mongodb
ADD $app$ /home/user/$app$
RUN unzip -q /home/user/$app$ -d /home/user
ENV ARGUMENTS $args$