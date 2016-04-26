FROM codenvy/ubuntu_jre
RUN sudo apt-get update && \
    sudo apt-get install g++ gcc make gdb gdbserver -y && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo rm -rf /var/lib/apt/lists/*
CMD tail -f /dev/null
