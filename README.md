1. Install VirtualBox
 - I've successfully used 4.2.22, 4.3.8, 4.3.12, 4.3.18
2. Install VirtualBox Extension Pack 
 - This is necessary to be able to PXE boot a VM without a iso file or
   using the default Intel network adapter
 - I had sucess on VBox 4.2.22 using the PCnet-FAST III (Am79C973)
   adapter without the extension pack but others reported issues to me
2. Install Vagrant
  - I've personally used 1.4.3, 1.6.3 in the past and 1.6.5 right now.
3. `vagrant plugin install oscar`
  - Optional: `vagrant plugin install vagrant-multiprovider-snap`
4. `vagrant up` 
  - Optional: `vagrant snap take`
5. Create VMs in virtual box to PXE boot
  - You can skip the specifics and use the example VM definition I created
    and placed in example_pxe_boot_vm otherwise continue reading
  - Create a VM with atleast 512MB of RAM
    - I tried 256MB and it froze during the PXE boot process
  - Under system: Add Network to be enabled in the Boot Order.  
    - It can be last but it needs to be enabled.
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
6. Start your new box and it will PXE boot and receive an image from the
   dhcp server.  
  - From there it will be handed off to the razor server. 
  - Razor will not provision the box until you setup a policy to do so
    - http://docs.puppetlabs.com/pe/latest/razor_using.html
  - Expect the box to load a microkernel and just sit there wating for
    razor to instruct it.   
7. The razor client is installed on the razor-server.  You can use
   the client to create a policy. 
  - WARNING: After you've created a policy and your box reboots to install
    the repo your policy defines it may fail to boot into the installation
    media due to an issue with virtualbox.  If you force close the vm and 
    reboot it will proceed as normal.  
8. If you would like to connect to the puppet enterprise console you can
   connect from your machine at https://192.168.51.22.  

If you run into any DNS issues then there's a few things to know.
The puppet-master, razor-server, and dhcp-server all have static ip
addresses assigned from the vagrant configuration.  They resolve each
other via `/etc/hosts`.  However, any new boxes you create to PXE boot
will automatically get an ip from the dhcp-server and will resolve
the razor-server via DNS that is setup on the dhcp-server.  

Wondering how the PXE booted box is able to connect to the internet?
The DHCP server is also acting like a router and forwarding ipv4 
traffic to the internet from the PXE booted boxes.

Total Stack Boot Time (timed on my laptop with SSD) 
 1. puppet-master 10 mins
 2. razor-server  15 mins
 3. dhcp-server   7  mins
