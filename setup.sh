# First run this. It will take forever. This is pulling down
# the `.h` files for your kernel. Rasbian doesn't use the same
# ones as the regular linux kernel. Ugh.
sudo apt-get install raspberrypi-kernel-headers

#Then pull down git and your build essential if you don't have them already.
sudo apt-get install git build-essential

#Install the driver
cd mt7610u_wifi_sta_v3002_dpo_20130916
make
sudo make install

#Copy the chipset `.dat` in to your wireless chipsets folder
sudo cp RT2870STA.dat  /etc/Wireless/RT2870STA/RT2870STA.dat

# At this point, after a reboot you should see the device as
# `ra0` in your `ip link` list. Configure it like you would
# any other wireless adapter.
echo "iface ra0 inet dhcp" | sudo tee -a /etc/network/interfaces
echo "	wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf" | sudo tee -a /etc/network/interfaces
sudo ifup ra0

# If you have a 5ghz network in your standard `wpa_supplicant.conf`
# set to highest priority, then ra0 will connect to that before
# a 2.4ghz network. Generally I use a separate wpa_supplicant file
# for each interface, but for simplicity you can just add your
# network to your existing one.
