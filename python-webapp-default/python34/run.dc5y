FROM codenvy/python34

ADD $app$ /home/user/$app$
RUN unzip -q /home/user/$app$ -d /home/user && \
    sudo virtualenv /env && \
    if [ -f /home/user/requirements.txt ]; then sudo /env/bin/pip3 install -r /home/user/requirements.txt; fi

EXPOSE 8080

CMD /env/bin/python /home/user/main.py
