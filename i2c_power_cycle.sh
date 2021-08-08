#!/bin/bash

pci_slot_name=$(lspci | grep -i "I2C Controller" | awk '{print $1}')
pci_path="/sys/bus/pci/devices/0000:"$pci_slot_name"/remove"

echo 1 > $pci_path && \
sleep 1 && \
echo 1 > /sys/bus/pci/rescan && \
echo "I2C controller successfully power-cycled"

if [ $? -ne 0 ]; then
    echo "FAILED: Unable to power-cycle I2C controller!"
fi
