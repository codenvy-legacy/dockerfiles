FROM fedora:23
ENV CC arm-linux-gnueabi-gcc
ENV CXX arm-linux-gnueabi-g++
ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX
ENV PATH $JAVA_HOME/bin:$PATH
ENV CPATH=/usr/arm-linux-gnueabi/include/artik/sdk
RUN dnf update -y && \
    dnf install dnf-plugins-core copr-cli -y && \
    dnf copr enable lantw44/arm-linux-gnueabi-toolchain -y && \
    dnf --enablerepo='*debug*' install android-tools arm-linux-gnueabi-{binutils,gcc,glibc} sudo usbutils openssh-server procps wget unzip mc git curl openssl bash passwd tar gdb sshpass cpio -y && \
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
ADD artik-libs-deps.zip /
RUN unzip artik-libs-deps.zip -d /usr/arm-linux-gnueabi/sys-root
RUN rm -rf /root/tmp && mkdir /root/tmp && wget -q https://install2.codenvycorp.com/artik-sdk-0.6.zip -P /root/tmp && \
    unzip -q /root/tmp/artik-sdk-0.6.zip -d /root/tmp && rm /root/tmp/artik-sdk-0.6.zip && \ 
    cd /root/tmp && \
    rpm2cpio /root/tmp/artik-sdk-0.6/RPMS/libartik-base-0.1.1-0.armv7hl.rpm | cpio -idmv &> /dev/null && \
    rpm2cpio /root/tmp/artik-sdk-0.6/RPMS/libartik-base-devel-0.1.1-0.armv7hl.rpm | cpio -idmv &> /dev/null && \
    rpm2cpio /root/tmp/artik-sdk-0.6/RPMS/libartik-sdk-devel-0.6-0.armv7hl.rpm | cpio -idmv &> /dev/null && \
    rpm2cpio /root/tmp/artik-sdk-0.6/RPMS/libartik-base-debuginfo-0.1.1-0.armv7hl.rpm | cpio -idmv  &> /dev/null && \
    rpm2cpio /root/tmp/artik-sdk-0.6/RPMS/libartik-sdk-0.6-0.armv7hl.rpm | cpio -idmv  &> /dev/null && \
    rpm2cpio /root/tmp/artik-sdk-0.6/RPMS/libartik-sdk-tests-0.6-0.armv7hl.rpm | cpio -idmv &> /dev/null && \
    cp -R /root/tmp/usr/lib/* /usr/arm-linux-gnueabi/sys-root/lib && cp -R /root/tmp/usr/* /usr/arm-linux-gnueabi
EXPOSE 22 4403
ENTRYPOINT ["/root/entrypoint.sh"]
WORKDIR /projects
CMD adb start-server && \
    tail -f /dev/null
