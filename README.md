1. Install Virtual Box
2. Install Vagrant 
3. `vagrant plugin install oscar`
  - Optional: `vagrant plugin install vagrant-multiprovider-snap`
4. `vagrant up` 
  - Optional: `vagrant snap take`
5. Manually create vms in virtual box to PXE box
  - Create a VM with atleast 512MB of RAM
  - Add Network to be enabled in the Boot Order.  It can be last but it
    needs to be enabled.
  - Under Network:
    - Attach it to Internal Network called `Razor_Network`.  This is the
      network the other 3 boxes are on
    - Change the Adapter Type to PCnet-FAST III (Am79C973)
      - This is the adapter type I used I'm not sure if the others work
6. Start your new box and it will PXE boot and receive an image from the
   dhcp server.  From there it will be handed off to the razor server.  


