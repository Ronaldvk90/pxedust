#!/bin/sh

cat <<EOT >/etc/dnsmasq.conf
#Don't function as a DNS server:
port=0

# Log lots of extra information about DHCP transactions.
log-dhcp

# Disable re-use of the DHCP servername and filename fields as extra
# option space. That's to avoid confusing some old or broken DHCP clients.
dhcp-no-override

######################################################
# Docker needs this to listen on the RIGHT interface #
######################################################
#interface=${INT_IF}

# The known types are x86PC, PC98, IA64_EFI, Alpha, Arc_x86,
# Intel_Lean_Client, IA32_EFI, ARM_EFI, BC_EFI, Xscale_EFI and X86-64_EFI
# This option is first and will be the default if there is no input from the user.

# PXEClient:Arch:00000
pxe-service=X86PC, "Boot BIOS PXE", undionly

# PXEClient:Arch:00007
pxe-service=BC_EFI, "Boot UEFI PXE-BC", snponly.efi

# PXEClient:Arch:00009
pxe-service=X86-64_EFI, "Boot UEFI PXE-64", snponly.efi

dhcp-range=${INT_IP},proxy,${INT_MASK}
EOT

/usr/sbin/dnsmasq --no-daemon
