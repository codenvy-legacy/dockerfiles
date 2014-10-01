FROM codenvy/ruby210_rails403

RUN sudo mkdir -p /home/user/app

ADD $app$/ /home/user/app

WORKDIR /home/user/app

RUN sudo chown -R user:user . && \
     /bin/bash -l -c "bundle install" && \
    chmod +x bin/*

EXPOSE 3000

CMD bin/rails server