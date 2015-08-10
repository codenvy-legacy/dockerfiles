FROM centos:centos7
ENV container docker
RUN yum -y update
RUN yum install -y initscripts e2fsprogs lxc sudo rsyslog mc httpd unzip wget mailx postfix openssh-server openssh-clients http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum reinstall -y glibc-common;  yum clean all
RUN echo "LANG=\"en_GB.UTF-8\"" > /etc/locale.conf
RUN mkdir -p /etc/systemd/system/multi-user.target.wants
RUN rm -f /etc/sysconfig/network-scripts/ifcfg-ens3
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-0.9.2-1.el7.noarch.rpm \
https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-firewalld-0.9.2-1.el7.noarch.rpm \
https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-server-0.9.2-1.el7.noarch.rpm \
https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-sendmail-0.9.2-1.el7.noarch.rpm --nodeps

VOLUME [ "/sys/fs/cgroup" ]
ADD schema.sql /usr/share/doc/zabbix-server-mysql-2.2.7/create/schema.sql
ADD data.sql /usr/share/doc/zabbix-server-mysql-2.2.7/create/data.sql
ADD images.sql /usr/share/doc/zabbix-server-mysql-2.2.7/create/images.sql
ADD ssh-keys.tar.gz /

CMD ["/usr/sbin/init"]


