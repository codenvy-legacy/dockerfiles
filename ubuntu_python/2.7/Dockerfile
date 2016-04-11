FROM codenvy/ubuntu_jre

# remove several traces of debian python
RUN sudo apt-get purge -y python.* && \
    sudo apt-get update && \
    sudo apt-get install -y gcc make python-pip zlibc zlib1g zlib1g-dev libssl-dev

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# gpg: key 18ADD4FF: public key "Benjamin Peterson <benjamin@python.org>" imported
ENV GPG_KEY C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF

ENV PYTHON_VERSION 2.7.11

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
    && sudo curl -fSL 'https://bootstrap.pypa.io/get-pip.py' | sudo python2 \
    && sudo pip install --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION \
    && sudo find /usr/local \
         \( -type d -a -name test -o -name tests \) \
         -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
         -exec rm -rf '{}' + \
    && sudo rm -rf /usr/src/python

# install "virtualenv", since the vast majority of users of this image will want it
RUN sudo pip install --no-cache-dir virtualenv
EXPOSE 8080
CMD tailf /dev/null
