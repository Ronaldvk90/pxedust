# Welcome to my bootserver!

First of all. This is partially due to legal issues not complete.

I deliver a OOBE dnsmasq server, tftp and nginx. The nginx server however is *not* fully populated! This due to size restrictions and legal issue (winpe). So the live operating systems have to be populated by hand. I removed my own rescue cd (contact me if you are curious). Furthermore i removed both fedora live images, Clonezilla and winpe. The ipxe files however are there. You just have to download these options yourself if you want them. 

For winpe you can use wimboot. The iPXE project has detailed information how to build and install winpe.
http://www.ipxe.org/wimboot

# The basics
To start the server, simply run *start.sh* in the root path of the repository. You will be prompted for a ipv4 address. This will be the internal ipv4 address of the server pxedust runs on.
if you want to change the ipv4 address for pxedust for a reason, run the *changeip.sh* script. 

# Populate the server.
Well... Thats about it to be honest.

I'd suggest again checking out the iPXE project for more information how to use .ipxe scripts and how to boot different operating systems.

Have fun! :)
