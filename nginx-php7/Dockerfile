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
  && chown -R user:user /var/log/php7 \
  && PHP_FPM_USER="user" \
  && PHP_FPM_GROUP="user" \
  && PHP_FPM_LISTEN_MODE="0660" \
  && PHP_MEMORY_LIMIT="512M" \
  && PHP_MAX_UPLOAD="50M" \
  && PHP_MAX_FILE_UPLOAD="200" \
  && PHP_MAX_POST="100M" \ 
  && PHP_DISPLAY_ERRORS="On" \
  && PHP_DISPLAY_STARTUP_ERRORS="On" \
  && PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR" \
  && PHP_CGI_FIX_PATHINFO=0 \
  && sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php7/php-fpm.d/www.conf \
  && sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php7/php.ini \
  && sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini \ 
  && sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php7/php.ini \ 
  && sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php7/php.ini \
  && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php7/php.ini \
  && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php7/php.ini \
  && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php7/php.ini \
  && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php7/php.ini \
  && sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php7/php.ini


COPY --chown=user test.php /var/www/localhost/htdocs/
COPY --chown=user nginx.conf /etc/nginx/nginx.conf
COPY --chown=user supervisord.conf /

USER user

EXPOSE 8080

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/supervisord.conf"]
