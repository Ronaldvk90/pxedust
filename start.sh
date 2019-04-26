#!/bin/bash

if ! [ -x "$(command -v docker-compose)" ]; then
echo 'Error: docker-compose is not installed or not in your path. Please visit https://docs.docker.com/compose/ for detailed information."' >&2
exit 1
fi

if [ -f ./tftp/files/undionly.0 ]; then
        echo -e "\e[31miPXE bootfiles seem to exist. Skipping generation.\e[0m"

docker-compose up -d
else
./.build.sh

docker-compose up -d
mv tftp/undionly.0 tftp/files/undionly.0
mv tftp/ipxe.efi tftp/files/ipxe.efi
fi
