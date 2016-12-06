# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
# Contributors:
# Codenvy, S.A. - initial API and implementation

FROM fedora:24
ENV CC arm-linux-gnueabi-gcc
ENV CXX arm-linux-gnueabi-g++
ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX
ENV PATH $JAVA_HOME/bin:$PATH
ENV CPATH=/usr/arm-linux-gnueabi/sys-root/usr/include/artik
ENV NODE_PATH=/usr/local/lib/node_modules
RUN dnf update -y && \
    dnf install dnf-plugins-core copr-cli -y && \
    dnf copr enable lantw44/arm-linux-gnueabi-toolchain -y && \
    dnf --enablerepo='*debug*' install nc android-tools arm-linux-gnueabi-{binutils,gcc,glibc} sudo usbutils openssh-server procps wget unzip mc git curl openssl bash passwd tar gdb sshpass cpio subversion -y && \
    dnf clean all && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i 's/requiretty/!requiretty/g' /etc/sudoers && \
    wget \
    --no-cookies \
    --no-check-certificate \
    --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    -qO- "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b17/jre-$JAVA_VERSION-linux-x64.tar.gz" | tar -zx -C /opt/ && \
    echo -e "#! /bin/bash\n set -e\nsudo /usr/bin/ssh-keygen -A\n sudo /usr/sbin/sshd -D &\n exec \"\$@\"" > /root/entrypoint.sh && chmod a+x /root/entrypoint.sh && \
    echo -e "export JAVA_HOME=/opt/jre$JAVA_VERSION_PREFIX\nexport CC=arm-linux-gnueabi-gcc\n export CXX=arm-linux-gnueabi-g++\nexport PATH=$JAVA_HOME/bin:$PATH" >> /root/.bashrc
RUN cd / && wget https://install.codenvycorp.com/artik/artik-libs-deps.zip && \
    unzip -q artik-libs-deps.zip -d /usr/arm-linux-gnueabi/sys-root && rm artik-libs-deps.zip
ADD artik.repo /etc/yum.repos.d/artik.repo
ADD RPM-GPG-KEY-artik /etc/pki/rpm-gpg/RPM-GPG-KEY-artik
RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-artik
RUN dnf makecache && dnf install --disablerepo=updates --disablerepo=lantw44-arm-linux-gnueabi-toolchain --disablerepo=fedora libartik-sdk-sysroot libartik-sdk-doc -y
EXPOSE 22 4403
ADD rsync.sh /usr/local/bin/rsync.sh
RUN chmod +x /usr/local/bin/rsync.sh
ENTRYPOINT ["/root/entrypoint.sh"]
WORKDIR /projects
CMD adb start-server && \
    tail -f /dev/null
