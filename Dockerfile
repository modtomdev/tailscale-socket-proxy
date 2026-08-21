FROM haproxy:3.4.2-alpine

EXPOSE 2375
ENV ALL=0 \
    CERT=1 \
    CHECK_PREFS=0 \
    CHECK_SO_MARK_IN_USE=0 \
    DERPMAP=0 \
    DISABLE_IPV6=0 \
    DNS_CONFIG=0 \
    GOROUTINES=0 \
    LOGIN_INTERACTIVE=0 \
    LOGOUT=0 \
    LOG_LEVEL=info \
    PEER_BY_ID=0 \
    PING=1 \
    POST=0 \
    PREFS=0 \
    PROFILES=0 \
    RELOAD_CONFIG=0 \
    RESET_AUTH=0 \
    ROOT=1 \
    SERVICES=0 \
    SET_EXPIRY_SOONER=0 \
    SHUTDOWN=0 \
    SOCKET_PATH=/var/run/tailscale/tailscaled.sock \
    START=0 \
    STATUS=1 \
    USER_PROFILE=0 \
    WHOIS=0
COPY docker-entrypoint.sh /usr/local/bin/
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg.template
RUN touch /var/lib/haproxy/server-state
USER root
CMD ["haproxy", "-f", "/tmp/haproxy.cfg"]
