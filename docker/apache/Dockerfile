FROM httpd:2.4

RUN apt-get update;
RUN apt-get -y upgrade;

#Install some basic packages
RUN apt-get -y install \
	bash \
	wget \
	ca-certificates \
	lsb-release \
	apt-transport-https;

#Add sury repo to able to install some php libraries
RUN wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

#Update repositories
RUN apt-get update;

#Install more libraries and apache modules
RUN apt-get -y install \
  nano \
  bash \
  apache2 \
  curl \
  openssl \
  git \
  tzdata \
  openntpd \
  php7.4 \
  libapache2-mod-fcgid;

#Enable installed apache modules
RUN a2enmod alias actions fcgid proxy proxy_fcgi rewrite

# Copy apache vhost file to proxy php requests to php-fpm container
COPY dareffort.conf /usr/local/apache2/conf/dareffort.apache.conf
RUN echo "Include /usr/local/apache2/conf/dareffort.apache.conf" >> /usr/local/apache2/conf/httpd.conf