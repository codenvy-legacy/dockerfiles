FROM codenvy/jdk7_gae1914
ADD $app$ /home/user/app/
RUN sudo chown -R user:user /home/user/app/
CMD ./dev_appserver.sh 2>&1 --disable_update_check -a 0.0.0.0 /home/user/app