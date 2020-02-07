CREATE DATABASE IF NOT EXISTS drupal_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER 'drupal'@'%' IDENTIFIED WITH mysql_native_password BY 'change_me';
GRANT ALL PRIVILEGES ON drupal_db.* TO 'drupal'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EXIT
