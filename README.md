1. Install Virtual Box
 - I use 4.2.22
 - I ran into issues downloading the microkernel when using 4.3.6
2. Install Vagrant 
3. `vagrant plugin install oscar`
  - Optional: `vagrant plugin install vagrant-multiprovider-snap`
4. `vagrant up` 
  - Optional: `vagrant snap take`
5. Manually create VMs in virtual box to PXE boot
  - Create a VM with atleast 512MB of RAM
    - I tried 256MB and it froze during the PXE boot process
  - Under system: Add Network to be enabled in the Boot Order.  
    - It can be last but it needs to be enabled.
  - Under Network:
    - Attach it to Internal Network called `Razor_Network`.  This is the
      network the other 3 boxes are on
    - Change the Adapter Type to PCnet-FAST III (Am79C973)
      - This is the adapter type I used I'm not sure if the others work
6. Start your new box and it will PXE boot and receive an image from the
   dhcp server.  
  - From there it will be handed off to the razor server. 
  - Razor will not provision the box until you setup a policy to do so
  - Expect the box to load a microkernel and just sit there wating for
    razor to instruct it.   
7. The razor client is installed on the razor-server.  You can use
   the client to create a policy. 

If you run into any DNS issues then there's a few things to know.
The puppet-master, razor-server, and dhcp-server all have static ip
addresses assigned from the vagrant configuration.  They resolve each
other via `/etc/hosts`.  However, any new boxes you create to PXE boot
will automatically get an ip from the dhcp-server and will resolve
the razor-server via DNS that is setup on the dhcp-server.  

Total Stack Boot Time (timed on my laptop with SSD) 
 1. puppet-master 10 mins
 2. razor-server  15 mins
 3. dhcp-server   7  mins
 ------------------------
                  32 mins  
