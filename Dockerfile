FROM centos:7

MAINTAINER chicpro <chicpro@gmail.com>

RUN yum -y install deltarpm

RUN yum -y install epel-release

RUN yum -y update

RUN yum -y install httpd redis vim

RUN yum -y install php php-cli php-bcmath php-bz2 php-common php-curl php-dba php-gd php-json php-mbstring php-opcache php-readline php-soap php-xml php-xmlrpc php-zip php-ctype php-pdo php-redis php-mysql php-imagick php-intl

RUN sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 100M/' /etc/php.ini
RUN sed -i 's/post_max_size = 8M/post_max_size = 100M/' /etc/php.ini

# Fix timezone issue
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY ./vhost.conf /etc/httpd/conf.d/

RUN systemctl enable redis

RUN systemctl enable httpd

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]