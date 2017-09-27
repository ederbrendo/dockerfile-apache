FROM centos
MAINTAINER "Eder Brendo" <eder.brendo@gmail.com>
RUN yum update -y
RUN yum install openssh net-tools wget vim ntsysv nano -y
RUN yum install httpd httpd-devel apr-devel openssl-devel mod_ssl -y
RUN wget http://downloads.jboss.org/mod_cluster//1.3.1.Final/linux-x86_64/mod_cluster-1.3.1.Final-linux2-x64-so.tar.gz
RUN tar zxvf mod_cluster-1.3.1.Final-linux2-x64-so.tar.gz
RUN mv *.so /etc/httpd/modules

COPY mod_cluster.conf /etc/httpd/conf.d/mod_cluster.conf

RUN sed -i -e 's/LoadModule proxy_balancer_module/#LoadModule proxy_balancer_module/g' /etc/httpd/conf.modules.d/00-proxy.conf

RUN htpasswd -b -c /etc/mcmpassword admin admin

RUN systemctl enable httpd.service

ENTRYPOINT ["/sbin/init"]
