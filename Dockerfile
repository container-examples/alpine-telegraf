FROM alpine:3.6

LABEL MAINTAINER="Aurelien PERRIER <perrie_a@etna-alternance.net>"
LABEL APP="telegraf"
LABEL APP_VERSION="1.4.3"
LABEL APP_REPOSITORY="https://github.com/influxdata/telegraf/releases"
LABEL APP_DESCRIPTION="logging"

ENV TIMEZONE Europe/Paris
ENV TELEGRAF_VERSION 1.4.4
ENV GOSU_VERSION 1.10

# Installing dependencies
RUN apk --update add --no-cache --virtual .build-deps wget tar

# Downloading binaries
RUN wget --no-check-certificate -q https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz
RUN wget --no-check-certificate -q -O /usr/bin/gosu https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-amd64

# Coping config & scripts
COPY ./files/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./scripts/start.sh start.sh

# Installing packages
RUN tar -C . -xzf telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x telegraf/* && \
        cp telegraf/telegraf /usr/bin/ && \
        rm -rf *.tar.gz* /root/.gnupg telegraf/ && \
        addgroup telegraf && \
        adduser -s /bin/false -G telegraf -S -D telegraf && \
        apk del .build-deps

ENTRYPOINT [ "./start.sh" ]