# Welcome to my bootserver!

I deliver a OOBE dnsmasq server, tftp and nginx.

For winpe you can use wimboot. The iPXE project has detailed information how to build and install winpe.
http://www.ipxe.org/wimboot

# The basics
To start the server, simply run *start.sh* in the root path of the repository. You will be prompted for a ipv4 address. This will be the internal ipv4 address of the server pxedust runs on.
if you want to change the ipv4 address for pxedust for a reason, run the *changeip.sh* script. 

# Populate the server.
Well... Thats about it to be honest.

I'd suggest again checking out the iPXE project for more information how to use .ipxe scripts and how to boot different operating systems.

Have fun! :)
