FROM fedora:23
RUN dnf update -y && \
	dnf install dnf-plugins-core copr-cli -y && \
	dnf copr enable lantw44/arm-linux-gnueabi-toolchain -y
RUN dnf --enablerepo='*debug*' install arm-linux-gnueabi-{binutils,gcc,glibc} sudo openssh-server procps wget unzip mc git curl nmap openssl bash passwd tar gdb gdb-gdbserver sshpass gcc glibc-debuginfo glibc-debuginfo-common -y && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    useradd -u 1000 -G users,wheel -d /home/user --shell /bin/bash -m user && \
    sed -i 's/requiretty/!requiretty/g' /etc/sudoers && \
    echo -e "root2016\nroot2016" | passwd root

ENV JAVA_VERSION=8u65 \
    JAVA_VERSION_PREFIX=1.8.0_65
ENV JAVA_HOME /opt/jre$JAVA_VERSION_PREFIX
ENV PATH $JAVA_HOME/bin:$PATH
RUN wget \
   --no-cookies \
   --no-check-certificate \
   --header "Cookie: oraclelicense=accept-securebackup-cookie" \
   -qO- \
   "http://download.oracle.com/otn-pub/java/jdk/$JAVA_VERSION-b17/jre-$JAVA_VERSION-linux-x64.tar.gz" | tar -zx -C /opt/

RUN echo -e "#! /bin/bash\n set -e\nsudo /usr/bin/ssh-keygen -A\n sudo /usr/sbin/sshd -D &\n exec \"\$@\"" > /home/user/entrypoint.sh && chmod a+x /home/user/entrypoint.sh

RUN echo -e "export JAVA_HOME=/opt/jre$JAVA_VERSION_PREFIX\nexport PATH=$JAVA_HOME/bin:$PATH" >> /home/user/.bashrc && \
	echo -e "set remotetimeout 10\nset sysroot /home/user/sysroot" > /home/user/.gdbinit

EXPOSE 22 4403 9000

ENV ARTIK_IP 172.17.0.3
ENV ARTIK_USER root
ENV ARTIK_PASS root2016
ENV CC gcc
ENTRYPOINT ["/home/user/entrypoint.sh"]
CMD echo "172.17.0.3 ARTIK_IP" >> /etc/hosts && tail -f /dev/null