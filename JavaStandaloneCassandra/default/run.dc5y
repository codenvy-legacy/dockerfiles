FROM codenvy/jdk7_cassandra
ADD $app$ /home/user/$app$
RUN unzip -q /home/user/$app$ -d /home/user
ENV ARGUMENTS $args$