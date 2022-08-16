FROM centos:7

RUN yum -y install centos-release-scl && yum -y install httpd24-httpd rh-php73 rh-php73-php rh-php73-php-mbstring rh-php73-php-mysqlnd rh-php73-php-gd rh-php73-php-xml rh-php73-php-intl mariadb && yum clean all

ENV MEDIAWIKI_MAJOR_VERSION 1.38

ENV MEDIAWIKI_VERSION 1.38.2

ENV USER apache

ADD https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz /opt/rh/httpd24/root/var/www/html

WORKDIR /opt/rh/httpd24/root/var/www/html

RUN tar xf mediawiki-${MEDIAWIKI_VERSION}.tar.gz && rm -f mediawiki-${MEDIAWIKI_VERSION}.tar.gz && ln -s mediawiki-${MEDIAWIKI_VERSION} mediawiki

# Unable to find pacakge for http2 module library so we need to comment out http2 module
COPY 00-base.conf /opt/rh/httpd24/root/etc/httpd/conf.modules.d/00-base.conf

RUN chown -R ${USER}:${USER} /opt/rh/httpd24

RUN chown -R ${USER}:${USER} /var/log/httpd24

# Run a smoke test
RUN  /opt/rh/httpd24/root/sbin/httpd -t

EXPOSE 80

USER ${USER}

CMD [ "/opt/rh/httpd24/root/sbin/httpd", "-DFOREGROUND" ]