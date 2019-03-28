FROM alpine:latest
MAINTAINER Benjamin Denhartog <ben@sudoforge.com>

RUN apk add --update --no-cache \
        weechat \
    && mkdir /root/.weechat

EXPOSE 9001

VOLUME /root/.weechat

CMD ["/usr/bin/weechat"]
