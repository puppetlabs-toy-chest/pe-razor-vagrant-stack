## How to Use This Stack

1. Install VirtualBox
 - I've successfully used 4.2.22, 4.3.8, 4.3.12, 4.3.18, 6.0.8
2. Install VirtualBox Extension Pack
 - This is necessary to be able to PXE boot a VM without a iso file or
   using the default Intel network adapter
 - I had sucess on VBox 4.2.22 using the PCnet-FAST III (Am79C973)
   adapter without the extension pack but others reported issues to me
3. Install Vagrant
  - Version 1.8+ is required (2.2.4 also works).
4. `vagrant plugin install oscar`
5. `vagrant up`
  - Optional: `vagrant snapshot save`
6. You can ssh into any of the boxes with `vagrant ssh <box_name>`
  - Please refer to the vagrant documentation if you are unfamiliar with vagrant
     - http://docs.vagrantup.com/v2/getting-started/index.html
7. Create VMs in virtual box to PXE boot
  - Import the VM definition I created and placed in `example_pxe_boot_vm`
8. Start your new box and it will PXE boot and receive an image from the
   dhcp server.
  - From there it will be handed off to the razor server.
  - Razor will not provision the box until you setup a policy to do so
    - http://docs.puppetlabs.com/pe/latest/razor_using.html
  - Expect the box to load a microkernel and just sit there wating for
    razor to instruct it.
9. The razor client is installed on the razor-server.  You can use
   the client to create a policy.
10. If you would like to connect to the puppet enterprise console you can
   connect from your machine at https://192.168.51.22.
  - The username is `admin` and the password is `puppetlabs`

## Creating a VM for PXE booting with Razor

If for some reason you don't want to use the VM definition in `example_pxe_boot_vm` then here are some notes of issues you might run into and how to avoid them.

  - Create a VM with at least 2048MB of RAM.
    - I tried 256MB and it froze during the PXE boot process
  - Under system: Add Network to be enabled in the Boot Order.
    - It must be first in the Boot Order list for reboot and reinstall to work properly.
  - Under system -> extended features: disable "Enable I/O APIC
    - I'm not sure why but if you don't the disable this you will get an error
      after razor tells the server with OS to install and reboots the server you
      will get an error like "FATAL: INT18: BOOT FAILURE"
  - Under Network:
    - Attach it to Internal Network called `Razor_Network`.  This is the
      network the other 3 boxes are on
    - If you run into issues with the download of the microkernel
      freezing during the download:
        - Make sure you've installed the virtualbox extension pack
        - You can also try changing to a different network adapter

## Networking Notes

If you run into any DNS issues then there's a few things to know.
The puppet-master, razor-server, and dhcp-server all have static ip
addresses assigned from the vagrant configuration.  They resolve each
other via `/etc/hosts`.  However, any new boxes you create to PXE boot
will automatically get an ip from the dhcp-server and will resolve
the razor-server via DNS that is setup on the dhcp-server.

Wondering how the PXE booted box is able to connect to the internet?
The DHCP server is also acting like a router and forwarding ipv4
traffic to the internet from the PXE booted boxes.

## Stack Boot Time

Total Stack Boot Time (timed on my laptop with SSD)
 1. puppet-master 10 mins
 2. razor-server  15 mins
 3. dhcp-server   7  mins


