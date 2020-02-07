FROM mysql

ENV MYSQL_DATABASE drupal_db

COPY ./mysql.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
