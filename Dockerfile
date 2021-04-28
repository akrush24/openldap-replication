FROM alpine:3.13

RUN apk add --update --no-cache \
        openldap \
        openldap-clients \
        openldap-back-mdb \
        openldap-overlay-syncprov \
        busybox-extras \
    && \
    rm -rf /var/cache/apk/* && \
    mkdir /run/openldap/
ADD entrypoint.sh /
WORKDIR /etc/openldap/conf.d
