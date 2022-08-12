FROM centos:7
RUN yum -y install centos-release-scl && yum -y install httpd24-httpd rh-php73 rh-php73-php rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-gd rh-php73-php-xml rh-php73-php-intl
ADD https://releases.wikimedia.org/mediawiki/1.38/mediawiki-1.38.2.tar.gz /opt/rh/httpd24/root/var/www/html
WORKDIR /opt/rh/httpd24/root/var/www/html
ENV MEDIAWIKI_MAJOR_VERSION 1.38
ENV MEDIAWIKI_VERSION 1.38.2
RUN tar xf mediawiki-1.38.2.tar.gz && rm -f mediawiki-1.38.2.tar.gz && ln -s mediawiki-1.38.2 mediawiki
COPY 00-base.conf /opt/rh/httpd24/root/etc/httpd/conf.modules.d/00-base.conf
RUN  /opt/rh/httpd24/root/sbin/httpd -t
EXPOSE 80
CMD [ "/opt/rh/httpd24/root/sbin/httpd", "-DFOREGROUND" ]