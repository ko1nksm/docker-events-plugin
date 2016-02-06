FROM alpine

RUN apk add --update bash wget ca-certificates bind-tools jq \
    && rm -rf /var/cache/apk/*

RUN wget -qO - https://get.docker.com/builds/Linux/x86_64/docker-1.9.1.tgz | tar zxf - \
    && chmod +x /usr/local/bin/docker

COPY docker-events-plugin /
COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["exec"]
