FROM codenvy/jdk7_vnc
RUN mkdir -p /home/user/cli
ENV CLI_HOME /home/user/cli
RUN echo "export CLI_HOME=$CLI_HOME" >> /home/user/.bashrc
ENV PATH $CLI_HOME:$PATH
RUN echo "export PATH=$PATH" >> /home/user/.bashrc