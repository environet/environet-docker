FROM php:7.4

#Create documentation script
COPY create-doc /usr/local/bin/create-doc

RUN apt-get update
RUN apt-get -y upgrade

#Install some basic lpackages
RUN apt-get -y install graphviz

#Install phpdoc
RUN curl --silent "https://api.github.com/repos/phpDocumentor/phpDocumentor/releases/latest" \
	| grep '"tag_name":' \
	| sed -E 's/.*"([^"]+)".*/\1/' \
	| xargs -I {} curl -sOL "https://github.com/phpDocumentor/phpDocumentor/releases/download/"{}'/phpDocumentor.phar' \
	&& mv phpDocumentor.phar /usr/local/bin/phpdoc \
	&& chmod +x /usr/local/bin/phpdoc ;

#Run phpdoc when the build is finished
CMD /usr/local/bin/create-doc