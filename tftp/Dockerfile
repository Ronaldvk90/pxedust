FROM alpine:3.9
RUN apk add --no-cache tftp-hpa
EXPOSE 69/udp
ENTRYPOINT ["in.tftpd"]
CMD ["-L", "--secure", "/var/tftpboot"]
