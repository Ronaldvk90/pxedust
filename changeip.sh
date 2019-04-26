#!/bin/bash
  
# Let the user input the BOOTURL variable. It is the ipv4 address used for ipxe binary.
echo -e "\e[32mPlease provide a valid ipv4 address like "192.168.1.1"\e[0m"
read -p 'ipv4 adress:' BOOTURL

# Here i provide a sanity check to make sure it is in ipv4 format.
if [[ $BOOTURL =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then

# Secretly hacking the boot url in the dnsmasq container. ;)
echo INT_IP=$BOOTURL > ./dnsmasq/env_file

# And offcourse updating nginx with the new ip! :)
sed -i -e "s/.*set url=.*/set url=$BOOTURL  /" webserver/files/menu.ipxe

# Building the container and deleting it after it is done building the files. It also copy's the files to the designated container.
mkdir -p ./buildcontainer
cd ./buildcontainer
cat << EOF >> ./Dockerfile

FROM ubuntu:bionic
RUN apt-get update ; apt-get upgrade -y
RUN apt-get install -y make gcc perl liblzma-dev binutils mtools git bash
RUN git clone https://git.ipxe.org/ipxe.git
RUN echo '#!ipxe\ndhcp\nchain http://$BOOTURL/menu.ipxe\nboot' > ipxe/src/embed.ipxe 
RUN echo '#!/bin/bash\ncd /ipxe/src\nmake bin/undionly.kpxe EMBED=embed.ipxe\nmake bin-x86_64-efi/ipxe.efi' > /make.sh
RUN chmod +x /make.sh
RUN /make.sh
CMD tail -f /dev/null
EOF

docker build -t buildcontainer .
docker run -d --name=buildcontainer -it buildcontainer
docker cp buildcontainer:ipxe/src/bin/undionly.kpxe ../tftp/files/undionly.0
docker cp buildcontainer:ipxe/src/bin-x86_64-efi/ipxe.efi ../tftp/files/

docker stop buildcontainer
docker rm buildcontainer
docker image rm buildcontainer
cd ..
rm -rf buildcontainer

docker stop pxedust_dnsmasq_1
docker rm pxedust_dnsmasq_1
docker image rm pxedust_dnsmasq
docker-compose up -d
exit 1

# Not my best work... Here i exit the sanity check.
else echo -e "\e[31mNot a valid ipv4 address. Please provide a valid ipv4 address like 10.10.10.1 or 192.168.1.1.\e[0m"
fi
