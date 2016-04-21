FROM fedora:23
ENV CC arm-linux-gnueabi-gcc
ENV CXX arm-linux-gnueabi-g++
ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX
ENV PATH $JAVA_HOME/bin:$PATH

RUN dnf update -y && \
	  dnf install dnf-plugins-core copr-cli -y && \
	  dnf copr enable lantw44/arm-linux-gnueabi-toolchain -y && \
    dnf --enablerepo='*debug*' install android-tools arm-linux-gnueabi-{binutils,gcc,glibc} sudo usbutils openssh-server procps wget unzip mc git curl nmap openssl bash passwd tar gdb gdb-gdbserver sshpass glibc-debuginfo glibc-debuginfo-common -y && \
    dnf clean all && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,wheel -d /home/user --shell /bin/bash -m user && \
    sed -i 's/requiretty/!requiretty/g' /etc/sudoers && \
    PASS=$(openssl rand -base64 32) && \
    echo -e "${PASS}\n${PASS}" | passwd user && \
    wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b17/jre-$JAVA_VERSION-linux-x64.tar.gz" | tar -zx -C /opt/ && \
   echo -e "#! /bin/bash\n set -e\nsudo /usr/bin/ssh-keygen -A\n sudo /usr/sbin/sshd -D &\n exec \"\$@\"" > /home/user/entrypoint.sh && chmod a+x /home/user/entrypoint.sh && \
   echo -e "export JAVA_HOME=/opt/jre$JAVA_VERSION_PREFIX\nexport CC=arm-linux-gnueabi-gcc\n export CXX=arm-linux-gnueabi-g++\nexport PATH=$JAVA_HOME/bin:$PATH" >> /home/user/.bashrc

EXPOSE 22 4403
ENTRYPOINT ["/home/user/entrypoint.sh"]
CMD adb start-server && \
    tail -f /dev/null
