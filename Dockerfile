FROM resin/raspberrypi3-alpine

ENV ORGANISATION_NAME "colachg Inc"
ENV SUFFIX "dc=colachg,dc=com"
ENV ROOT_USER "admin"
ENV ROOT_PW "password"
ENV USER_UID "uid"
ENV USER_GIVEN_NAME "colachg"
ENV USER_SURNAME "coco"
ENV USER_EMAIL "colachg@gmail.com"
ENV ACCESS_CONTROL "access to * by * read"
ENV LOG_LEVEL "stats"

RUN apk add --update openldap openldap-back-mdb && \
    mkdir -p /run/openldap /var/lib/openldap/openldap-data && \
    rm -rf /var/cache/apk/*

COPY scripts/* /etc/openldap/
COPY docker-entrypoint.sh /

EXPOSE 389
EXPOSE 636

VOLUME ["/ldif", "/var/lib/openldap/openldap-data"]

ENTRYPOINT ["/docker-entrypoint.sh"]