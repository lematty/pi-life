# Here is a list of things I usually install on a Raspberry Pi. I'll automate some of these eventually.

## Change default password
The default password for a Raspberry Pi is `raspberry`. Always a good idea to change that right away.
```
passwd
```

## Update and Upgrade packages
```
sudo apt update && sudo apt full-upgrade
```

## Install vim
```
sudo apt install vim
```

## Hide plain text wifi password
If you'd like to hide your password from being in plain text in the wpa_supplicant.conf file, you can use wpa_passphrase to hide it.

```
wpa_passphrase [ssid] '[password]'
```
..without the brackets of course. Also notice the single quotes, this helps in case of special characters.

This will display something similar to what you have added in one of the first steps to connect to wifi directly.
```
network={
	ssid="ssid"
	#psk="password"
	psk=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
}
```
You'll notice that the real password is commented out. This is just until you make sure the obscured one is working. SAfter you should remove the commented password.

Then open and replace the "network" value in inside `/etc/wpa_supplicant/wpa_supplicant.conf` with this new value and reboot.
```
sudo vim /etc/wpa_supplicant/wpa_supplicant.conf
# save and exit (':wq' with vim)
sudo reboot
```
After the pi reboots, you should be able to connect through ssh as before. Once connected, open the wpa_supplicant.conf file one last time to remove the plain text password. Again save and reboot.
