# I2C SYNA7DB5 Touchpad fix

## Issue and possible solutions

This shell script has been developed to fix an issue with a Synaptics touchpad ( `06CB:7DB7` ) which, when set to communicate over i2c (usually called "Advanced mode" in the BIOS settings), doesn't work properly on Linux. In my case, I was unable to move the cursor at all.

A common solution, which didn't work out for me, is reloading the driver. Since this touchpad uses `hid_multitouch`, the commands would be:

```
modprobe -r hid_multitouch
modprobe hid_multitouch
```

Instead, what I found to be effective is removing the I2C controller from the PCI bus and adding it back, which in practice power-cycles it.
This is what the script does.

DISCLAIMER: I have no idea if said operation can be dangerous to the hardware. If other devices are connected to the I2C controller it can mess with them too. DO IT AT YOUR OWN RISK

## Keyboard shortcut 
For ease of use, I have set-up a keyboard shortcut to trigger the execution of the script. Since it requires root privileges, `polkit` with `pkexec` is used to grant them from the GUI.

```
bash -c 'notify-send "$(pkexec ~/i2c_power_cycle.sh)"'
```