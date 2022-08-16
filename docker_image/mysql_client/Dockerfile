FROM ubuntu:20.04

RUN apt update && apt install mariadb-client -y && apt clean all

ENV DB_HOST=""

ENV DB_NAME=""

ENV DB_PASSWORD=""

ENV DB_USER=""

ENV DB_SSL=false

COPY ./entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]