## SSH to Raspberry Pi

To SSH into the raspberry pi, you will first need to connect the pi to the network. This can be done either by connecting directly to the router or switch by an ethernet cable, or by wifi. 

## Get IP address of Raspberry Pi
If connecting via `ethernet`, connect the pi directly to the router or switch via an ethernet cable. If connecting by `wifi`, I'm going to assume that you have added the wifi credentials in the `wpa_supplicant.conf` when flashing the SD card as described [here](../copy-os-to-sd-card). Then just power on your pi and wait a few minutes for it to boot up. 

In both cases, your router should have assined an internal IP address to the pi. You should be able to find the IP address of the pi on the network.

Now you can simply ping `raspberrypi.local` to find the IP address on the network
```
ping raspberrypi.local
```
This will ping the raspberry pi and return the results of the ping and the IP address of the pi. After a few pings you can stop it with `control + c`. 

```
PING raspberrypi.local (192.168.1.100): 56 data bytes
64 bytes from 192.168.1.100: icmp_seq=0 ttl=64 time=212.388 ms
64 bytes from 192.168.1.100: icmp_seq=1 ttl=64 time=16.419 ms
64 bytes from 192.168.1.100: icmp_seq=2 ttl=64 time=16.072 ms
```
## SSH to Raspberry Pi
Now that we have the IP address of the pi, we can connect to it via SSH with `ssh pi@<Pi-IP-Address>`. In this case we know the IP address is `192.168.1.100`.
```
ssh pi@192.168.1.100
```

You will then see something along the lines of:
```
The authenticity of host '192.168.1.100 (192.168.1.100)' can't be established.
ECDSA key fingerprint is SHA256:ABCDEFGHIJKLMNOPQRSTUVWXYZABCDEFGHIJKLMNOPQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? 
```
This is normal since its the first time you are connecting to it. You can just type `yes` then hit enter to continue.
```
Warning: Permanently added '192.168.1.100' (ECDSA) to the list of known hosts.
pi@192.168.1.100's password:
```
The default password is `"raspberry"`. Enter the password and hit enter to continue.

```
Linux raspberrypi 5.10.17+ #1414 Fri Apr 30 13:16:27 BST 2021 armv6l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.

SSH is enabled and the default password for the 'pi' user has not been changed.
This is a security risk - please login as the 'pi' user and type 'passwd' to set a new password.

pi@raspberrypi:~ $
```

That's it! You're now connected to your raspberry pi via SSH!

One last thing. As the message explains, it is not a good idea to leave the password as the default `"raspberry"`.

To update this, simply type 
```
passwd
```
Follow the prompt entering the current password of `"raspberry"`, then update it to your new desired password.
## Troubleshooting
### Not finding IP address
First check the IP address range that is being assigned by the router inside your system preferences. 
```
System Preferences -> Network -> Advanced - TCP/IP
```
There you should see IPv4 address with an assigned IP to your computer. We could imagine it says 

```
IPv4 Address: 192.168.1.100
Subnet Mask: 255.255.255.0
Router Address: 192.168.1.1
```

In this case we know that it is using `192.168.1.X` to assign IPs.

We can then do a scan to find the IPs of devices on the network in this range.
```
sudo nmap -sn 192.168.1.0/24
```
This will list the devices found on the network along with a small description. You should see one that said something related to Raspberry Pi.

```
MAC Address: AA:99:AA:99:99:99 (Raspberry Pi Foundation)
Nmap scan report for 192.168.1.100
Host is up.
```
We have found the IP address of the raspberry pi on the network. 

If this still hasn't worked and you are connecting via wifi, you may want to double check the `wpa_supplicant.conf` contains the correct SSID and password.

## Unable to SSH 
Have you enabled SSH when flashing the SD card as described [here](../copy-os-to-sd-card#optional-enable-ssh-on-raspberry-pi)?
