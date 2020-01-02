FROM mariadb:10.2
#COPY 01-init.sql /docker-entrypoint-initdb.d/
RUN apt-get update \
 && apt-get install --no-install-recommends -y tzdata \
 && apt-get clean \
 && rm -r /var/lib/apt/lists/*
EXPOSE 3306
