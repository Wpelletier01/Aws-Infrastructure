CREATE DATABASE glpi;

CREATE USER 'glpi'@'192.168.56.12' IDENTIFIED BY 'crosemont';

GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'192.168.56.12';

FLUSH PRIVILEGES;