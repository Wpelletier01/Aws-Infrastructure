FROM mariadb:latest


COPY glpi.sql /docker-entrypoint-initdb.d/
COPY mattermost.sql /docker-entrypoint-initdb.d/
COPY nextcloud.sql /docker-entrypoint-initdb.d/

ENV MARIADB_ROOT_PASSWORD="crosemont"


EXPOSE 3306