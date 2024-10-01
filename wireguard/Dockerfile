FROM alpine:3.20.3

RUN apk add --no-cache \
    wireguard-tools \
    iptables \
    iptables-legacy \
    kubectl \
    sudo \
    tcpdump \
    && rm -rf /var/cache/apk/*

RUN ln -sf /sbin/iptables-legacy /sbin/iptables \
    && ln -sf /sbin/iptables-legacy /sbin/iptables-restore \
    && ln -sf /sbin/iptables-legacy /sbin/iptables-save

RUN addgroup -g 1000 wireguard \
    && adduser -u 1000 -G wireguard -h /home/wireguard -D wireguard \
    && echo '%wheel ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/wheel \
    && adduser wireguard wheel

USER wireguard
WORKDIR /home/wireguard

COPY --chown=wireguard:wireguard ./entrypoint.sh ./entrypoint.sh

CMD ["./entrypoint.sh"]