# My alpine base image

FROM alpine:3.10

ENV PHP_V 7
ENV SOFT nginx \
 supervisor \
 wget

ENV PHP_MOD php${PHP_V}-fpm \
 php${PHP_V}-common \
 php${PHP_V}-mysqli \
 php${PHP_V}-json \
 php${PHP_V}-openssl \
 php${PHP_V}-curl \
 php${PHP_V}-session \
 php${PHP_V}-pdo \
 php${PHP_V}-pdo_mysql \
 php${PHP_V}-dom \
 php${PHP_V}-simplexml \
 php${PHP_V}-xml \
 php${PHP_V}-xmlrpc \
 php${PHP_V}-tokenizer \
 php${PHP_V}-common \
 php${PHP_V}-opcache \
 php${PHP_V}-mbstring \
 php${PHP_V}-gd

RUN apk update \
  && apk --no-cache add ${SOFT} ${PHP_MOD} \
  && mkdir -p /usr/share/webapps/ \
  && cd /usr/share/webapps \
  && wget https://ftp.drupal.org/files/projects/drupal-8.8.2.tar.gz \
  && tar zxvf drupal* \
  && rm *.tar.gz \
  && mv drupal* drupal \
  && addgroup -g 1000 user && adduser -u 1000 -D -G user user \
  && chown -R user:user /usr/share/webapps \
  && cp  /usr/share/webapps/drupal/sites/default/default.settings.php /usr/share/webapps/drupal/sites/default/settings.php \
  && ln -s /usr/share/webapps/drupal/ /var/www/localhost/htdocs/drupal \
  && mkdir /run/nginx \
  && touch /run/nginx/nginx.pid \
  && touch /run/supervisord.pid \
  && chown -R user:user /run/nginx/nginx.pid \
  && chown -R user:user /run/supervisord.pid \
  && chown -R user:user /usr/share/webapps/drupal/sites/default/settings.php \
  && chown -R user:user /var/lib/nginx \
  && chown -R user:user /var/tmp/nginx \
  && chown -R user:user /var/log/nginx \
  && chown -R user:user /var/log/php7

COPY --chown=user test.php /var/www/localhost/htdocs/
COPY --chown=user nginx.conf /etc/nginx/nginx.conf
COPY --chown=user supervisord.conf /

USER user

EXPOSE 8080

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
