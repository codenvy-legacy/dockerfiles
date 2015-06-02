FROM codenvy/ruby210
RUN echo 'source /etc/profile.d/rvm.sh' >> /home/user/.bashrc
ADD $app$/ /home/user
CMD ruby /home/user/main.rb