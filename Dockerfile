FROM alpine:3.7

LABEL MAINTAINER="Aurelien PERRIER <a.perrier89@gmail.com>"
LABEL APP="telegraf"
LABEL APP_REPOSITORY="https://github.com/influxdata/telegraf/releases"

ENV TIMEZONE Europe/Paris
ENV TELEGRAF_VERSION 1.5.2

# Work path
WORKDIR /scripts

# Downloading Telegraf
ADD https://dl.influxdata.com/telegraf/releases/telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz ./

# Coping config & scripts
COPY ./scripts/start.sh start.sh

# Installing packages
RUN tar -C . -xzf telegraf-${TELEGRAF_VERSION}-static_linux_amd64.tar.gz && \
        chmod +x telegraf/* && \
        cp telegraf/telegraf /usr/bin/ && \
        rm -rf *.tar.gz* telegraf/ 

ENTRYPOINT [ "./start.sh" ]