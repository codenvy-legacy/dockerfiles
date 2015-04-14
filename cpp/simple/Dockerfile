FROM codenvy/cpp
ENV CODENVY_APP_BIND_DIR /home/user/app
VOLUME ["/home/user/app"]
CMD cd /home/user/app && \
    make && \
    ./a.out
