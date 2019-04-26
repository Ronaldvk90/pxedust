FROM alpine:3.9

RUN apk --no-cache add dnsmasq
ADD files/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
