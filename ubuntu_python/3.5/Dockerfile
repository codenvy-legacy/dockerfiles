FROM codenvy/ubuntu_jre

# remove several traces of debian python 
RUN sudo apt-get purge -y python.* && \
    sudo apt-get update && \
    sudo apt-get install -y gcc make python3-pip

# http://bugs.python.org/issue19846 # > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK. 
ENV LANG C.UTF-8 

# gpg: key F73C700D: public key "Larry Hastings <larry@hastings.org>" imported 
ENV GPG_KEY 97FC712E4C024BBEA48A61ED3A5CA953F73C700D 
ENV PYTHON_VERSION 3.5.1 

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'" 
ENV PYTHON_PIP_VERSION 8.1.1 

RUN set -ex \
	&& sudo curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" -o python.tar.xz \
	&& sudo curl -fSL "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" -o python.tar.xz.asc \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY" \
	&& gpg --batch --verify python.tar.xz.asc python.tar.xz \
	&& sudo rm -r "$GNUPGHOME" python.tar.xz.asc \
	&& sudo mkdir -p /usr/src/python \
	&& sudo tar -xJC /usr/src/python --strip-components=1 -f python.tar.xz \
	&& sudo rm python.tar.xz \
	\
	&& cd /usr/src/python \
	&& sudo ./configure --enable-shared --enable-unicode=ucs4 \
	&& sudo make -j$(nproc) \
	&& sudo make install \
	&& sudo ldconfig \
	&& sudo pip3 install --upgrade --ignore-installed pip==$PYTHON_PIP_VERSION \
	&& sudo find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& sudo rm -rf /usr/src/python

# make some useful symlinks that are expected to exist 
RUN cd /usr/local/bin \
	&& sudo ln -s easy_install-3.5 easy_install \
	&& sudo ln -s idle3 idle \
	&& sudo ln -s pydoc3 pydoc \
	&& sudo ln -s python3 python \
	&& sudo ln -s python-config3 python-config
RUN sudo pip install --no-cache-dir virtualenv

EXPOSE 8080 

CMD tailf /dev/null