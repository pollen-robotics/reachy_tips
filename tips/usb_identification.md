## This document was created during Zuuu's integration

The RPLIDAR S2 is connected to the same USB hub than the 3 VESC controllers.
This USB HUB is connected to the NUC.
The head USB cable is connected to the NUC.
Two gates are connected to a USB hub that is connected to the NUC.

Keeping this file as a bad guide on how to setup udev rules.

### udev rules created with this guide
Create the file ```/etc/udev/rules.d/11-zuuu.rules``` and add:
```
File Edit Options Buffers Tools Help                                                                                                                                                                       
# Rules for RPLIDAR S2
KERNEL=="ttyUSB[0-9]", ATTRS{idVendor}=="10c4", ATTRS{idProduct}=="ea60", MODE="666", SYMLINK+="rplidar_s2"

# Rules for VESC controllers
KERNEL=="ttyACM[0-9]", ATTRS{idVendor}=="05e3", ATTRS{idProduct}=="0610", MODE="666", SYMLINK+="vesc_wheels"

# Rules for the 3 gates
KERNEL=="ttyUSB[0-9]", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", ATTRS{serial}=="D3096WZQ", MODE="666", SYMLINK+="gate0"
KERNEL=="ttyUSB[0-9]", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", ATTRS{serial}=="D3096X0S", MODE="666", SYMLINK+="gate1"
KERNEL=="ttyUSB[0-9]", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6015", ATTRS{serial}=="D307RR2E", MODE="666", SYMLINK+="gate2"
```
=> The "serial" values are robot dependent :/

### To reload udev rules
```
sudo udevadm control --reload-rules && sudo service udev restart && sudo udevadm trigger
```

### LIDAR :
Finding the device with ```lsusb``` and plugging/unplugging:
```
Bus 001 Device 016: ID 10c4:ea60 Silicon Labs CP210x UART Bridge
```
When unplugged udevadm says:
```
udevadm monitor 
monitor will print the received events for:
UDEV - the event which udev sends out after rule processing
KERNEL - the kernel uevent

KERNEL[991.245477] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3/tty/ttyUSB3 (tty)
KERNEL[991.245549] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3 (usb-serial)
KERNEL[991.245585] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3 (usb-serial)
KERNEL[991.245615] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/gpio/gpiochip181 (gpio)
KERNEL[991.245817] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/gpiochip4 (gpio)
KERNEL[991.245897] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/gpiochip4 (gpio)
KERNEL[991.245949] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0 (usb)
KERNEL[991.246013] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0 (usb)
UDEV  [991.249707] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3/tty/ttyUSB3 (tty)
UDEV  [991.249771] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/gpio/gpiochip181 (gpio)
UDEV  [991.250981] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/gpiochip4 (gpio)
KERNEL[991.251568] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4 (usb)
KERNEL[991.251622] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4 (usb)
UDEV  [991.251646] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/gpiochip4 (gpio)
UDEV  [991.251753] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3 (usb-serial)
UDEV  [991.252403] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3 (usb-serial)
UDEV  [991.253450] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0 (usb)
UDEV  [991.254472] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0 (usb)
UDEV  [991.255923] unbind   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4 (usb)
UDEV  [991.257064] remove   /devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4 (usb)
```

Possible udev rule tags are below:
```
udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB3)

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3/tty/ttyUSB3':
    KERNEL=="ttyUSB3"
    SUBSYSTEM=="tty"
    DRIVER==""

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0/ttyUSB3':
    KERNELS=="ttyUSB3"
    SUBSYSTEMS=="usb-serial"
    DRIVERS=="cp210x"
    ATTRS{port_number}=="0"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4/1-6.4:1.0':
    KERNELS=="1-6.4:1.0"
    SUBSYSTEMS=="usb"
    DRIVERS=="cp210x"
    ATTRS{bInterfaceProtocol}=="00"
    ATTRS{bAlternateSetting}==" 0"
    ATTRS{supports_autosuspend}=="1"
    ATTRS{bInterfaceClass}=="ff"
    ATTRS{bInterfaceNumber}=="00"
    ATTRS{bNumEndpoints}=="02"
    ATTRS{authorized}=="1"
    ATTRS{bInterfaceSubClass}=="00"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.4':
    KERNELS=="1-6.4"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{authorized}=="1"
    ATTRS{bcdDevice}=="0100"
    ATTRS{maxchild}=="0"
    ATTRS{bMaxPower}=="100mA"
    ATTRS{serial}=="8a8b3afd2e13ec118249fbef7a109228"
    ATTRS{idVendor}=="10c4"
    ATTRS{devpath}=="6.4"
    ATTRS{bDeviceProtocol}=="00"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{version}==" 2.00"
    ATTRS{removable}=="unknown"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{rx_lanes}=="1"
    ATTRS{ltm_capable}=="no"
    ATTRS{bmAttributes}=="80"
    ATTRS{tx_lanes}=="1"
    ATTRS{manufacturer}=="Silicon Labs"
    ATTRS{quirks}=="0x0"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{speed}=="12"
    ATTRS{devnum}=="23"
    ATTRS{busnum}=="1"
    ATTRS{urbnum}=="4665"
    ATTRS{configuration}==""
    ATTRS{bDeviceClass}=="00"
    ATTRS{product}=="CP2102N USB to UART Bridge Controller"
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{idProduct}=="ea60"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6':
    KERNELS=="1-6"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{busnum}=="1"
    ATTRS{removable}=="removable"
    ATTRS{maxchild}=="4"
    ATTRS{bDeviceProtocol}=="01"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{product}=="USB2.1 Hub"
    ATTRS{urbnum}=="40"
    ATTRS{configuration}==""
    ATTRS{authorized}=="1"
    ATTRS{manufacturer}=="GenesysLogic"
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bDeviceClass}=="09"
    ATTRS{devnum}=="21"
    ATTRS{ltm_capable}=="no"
    ATTRS{version}==" 2.10"
    ATTRS{idVendor}=="05e3"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{devpath}=="6"
    ATTRS{bcdDevice}=="0663"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{speed}=="480"
    ATTRS{bmAttributes}=="e0"
    ATTRS{quirks}=="0x0"
    ATTRS{rx_lanes}=="1"
    ATTRS{tx_lanes}=="1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{idProduct}=="0610"
    ATTRS{bMaxPower}=="100mA"
    ATTRS{bMaxPacketSize0}=="64"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1':
    KERNELS=="usb1"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{removable}=="unknown"
    ATTRS{idProduct}=="0002"
    ATTRS{devnum}=="1"
    ATTRS{quirks}=="0x0"
    ATTRS{rx_lanes}=="1"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{interface_authorized_default}=="1"
    ATTRS{devpath}=="0"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{tx_lanes}=="1"
    ATTRS{product}=="xHCI Host Controller"
    ATTRS{version}==" 2.00"
    ATTRS{configuration}==""
    ATTRS{speed}=="480"
    ATTRS{bcdDevice}=="0513"
    ATTRS{serial}=="0000:00:14.0"
    ATTRS{authorized_default}=="1"
    ATTRS{bMaxPower}=="0mA"
    ATTRS{busnum}=="1"
    ATTRS{bDeviceProtocol}=="01"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{authorized}=="1"
    ATTRS{ltm_capable}=="no"
    ATTRS{urbnum}=="164"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{manufacturer}=="Linux 5.13.0-40-generic xhci-hcd"
    ATTRS{bDeviceClass}=="09"
    ATTRS{bmAttributes}=="e0"
    ATTRS{idVendor}=="1d6b"
    ATTRS{maxchild}=="12"

  looking at parent device '/devices/pci0000:00/0000:00:14.0':
    KERNELS=="0000:00:14.0"
    SUBSYSTEMS=="pci"
    DRIVERS=="xhci_hcd"
    ATTRS{power_state}=="D0"
    ATTRS{irq}=="127"
    ATTRS{dma_mask_bits}=="64"
    ATTRS{msi_bus}=="1"
    ATTRS{device}=="0x9ded"
    ATTRS{class}=="0x0c0330"
    ATTRS{driver_override}=="(null)"
    ATTRS{vendor}=="0x8086"
    ATTRS{revision}=="0x30"
    ATTRS{enable}=="1"
    ATTRS{subsystem_vendor}=="0x8086"
    ATTRS{local_cpulist}=="0-3"
    ATTRS{dbc}=="disabled"
    ATTRS{broken_parity_status}=="0"
    ATTRS{consistent_dma_mask_bits}=="64"
    ATTRS{numa_node}=="-1"
    ATTRS{local_cpus}=="f"
    ATTRS{ari_enabled}=="0"
    ATTRS{subsystem_device}=="0x2082"
    ATTRS{d3cold_allowed}=="1"

  looking at parent device '/devices/pci0000:00':
    KERNELS=="pci0000:00"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{waiting_for_supplier}=="0"
```

### Same process for VESC controllers
```
udevadm info -a -p $(udevadm info -q path -n /dev/ttyACM0)

Udevadm info starts with the device specified by the devpath and then
walks up the chain of parent devices. It prints for every device
found, all possible attributes in the udev rules key format.
A rule to match, can be composed by the attributes of the device
and the attributes from one single parent device.

  looking at device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.3/1-6.3:1.0/tty/ttyACM0':
    KERNEL=="ttyACM0"
    SUBSYSTEM=="tty"
    DRIVER==""

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.3/1-6.3:1.0':
    KERNELS=="1-6.3:1.0"
    SUBSYSTEMS=="usb"
    DRIVERS=="cdc_acm"
    ATTRS{bInterfaceClass}=="02"
    ATTRS{authorized}=="1"
    ATTRS{bInterfaceNumber}=="00"
    ATTRS{bInterfaceProtocol}=="01"
    ATTRS{bNumEndpoints}=="01"
    ATTRS{supports_autosuspend}=="1"
    ATTRS{bAlternateSetting}==" 0"
    ATTRS{bmCapabilities}=="2"
    ATTRS{bInterfaceSubClass}=="02"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6/1-6.3':
    KERNELS=="1-6.3"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{idProduct}=="5740"
    ATTRS{bDeviceProtocol}=="00"
    ATTRS{urbnum}=="5098"
    ATTRS{authorized}=="1"
    ATTRS{tx_lanes}=="1"
    ATTRS{busnum}=="1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{idVendor}=="0483"
    ATTRS{bcdDevice}=="0200"
    ATTRS{devnum}=="25"
    ATTRS{rx_lanes}=="1"
    ATTRS{bNumInterfaces}==" 2"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{ltm_capable}=="no"
    ATTRS{configuration}==""
    ATTRS{bmAttributes}=="c0"
    ATTRS{devpath}=="6.3"
    ATTRS{speed}=="12"
    ATTRS{bMaxPower}=="100mA"
    ATTRS{manufacturer}=="STMicroelectronics"
    ATTRS{maxchild}=="0"
    ATTRS{product}=="ChibiOS/RT Virtual COM Port"
    ATTRS{serial}=="304"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{quirks}=="0x0"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{version}==" 1.10"
    ATTRS{bDeviceClass}=="02"
    ATTRS{removable}=="unknown"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1/1-6':
    KERNELS=="1-6"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{speed}=="480"
    ATTRS{manufacturer}=="GenesysLogic"
    ATTRS{busnum}=="1"
    ATTRS{version}==" 2.10"
    ATTRS{quirks}=="0x0"
    ATTRS{rx_lanes}=="1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{devpath}=="6"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{authorized}=="1"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{configuration}==""
    ATTRS{bcdDevice}=="0663"
    ATTRS{ltm_capable}=="no"
    ATTRS{bMaxPower}=="100mA"
    ATTRS{product}=="USB2.1 Hub"
    ATTRS{removable}=="removable"
    ATTRS{devnum}=="24"
    ATTRS{bNumInterfaces}==" 1"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{tx_lanes}=="1"
    ATTRS{urbnum}=="40"
    ATTRS{bDeviceClass}=="09"
    ATTRS{bmAttributes}=="e0"
    ATTRS{maxchild}=="4"
    ATTRS{idVendor}=="05e3"
    ATTRS{bDeviceProtocol}=="01"
    ATTRS{idProduct}=="0610"

  looking at parent device '/devices/pci0000:00/0000:00:14.0/usb1':
    KERNELS=="usb1"
    SUBSYSTEMS=="usb"
    DRIVERS=="usb"
    ATTRS{bMaxPacketSize0}=="64"
    ATTRS{speed}=="480"
    ATTRS{bNumConfigurations}=="1"
    ATTRS{bDeviceClass}=="09"
    ATTRS{devpath}=="0"
    ATTRS{rx_lanes}=="1"
    ATTRS{serial}=="0000:00:14.0"
    ATTRS{tx_lanes}=="1"
    ATTRS{urbnum}=="186"
    ATTRS{authorized_default}=="1"
    ATTRS{interface_authorized_default}=="1"
    ATTRS{removable}=="unknown"
    ATTRS{bcdDevice}=="0513"
    ATTRS{idProduct}=="0002"
    ATTRS{avoid_reset_quirk}=="0"
    ATTRS{quirks}=="0x0"
    ATTRS{busnum}=="1"
    ATTRS{maxchild}=="12"
    ATTRS{bmAttributes}=="e0"
    ATTRS{manufacturer}=="Linux 5.13.0-40-generic xhci-hcd"
    ATTRS{authorized}=="1"
    ATTRS{bConfigurationValue}=="1"
    ATTRS{configuration}==""
    ATTRS{product}=="xHCI Host Controller"
    ATTRS{devnum}=="1"
    ATTRS{idVendor}=="1d6b"
    ATTRS{version}==" 2.00"
    ATTRS{bDeviceProtocol}=="01"
    ATTRS{ltm_capable}=="no"
    ATTRS{bMaxPower}=="0mA"
    ATTRS{bDeviceSubClass}=="00"
    ATTRS{bNumInterfaces}==" 1"

  looking at parent device '/devices/pci0000:00/0000:00:14.0':
    KERNELS=="0000:00:14.0"
    SUBSYSTEMS=="pci"
    DRIVERS=="xhci_hcd"
    ATTRS{ari_enabled}=="0"
    ATTRS{d3cold_allowed}=="1"
    ATTRS{broken_parity_status}=="0"
    ATTRS{subsystem_vendor}=="0x8086"
    ATTRS{msi_bus}=="1"
    ATTRS{dma_mask_bits}=="64"
    ATTRS{vendor}=="0x8086"
    ATTRS{power_state}=="D0"
    ATTRS{irq}=="127"
    ATTRS{local_cpulist}=="0-3"
    ATTRS{numa_node}=="-1"
    ATTRS{class}=="0x0c0330"
    ATTRS{dbc}=="disabled"
    ATTRS{revision}=="0x30"
    ATTRS{local_cpus}=="f"
    ATTRS{subsystem_device}=="0x2082"
    ATTRS{device}=="0x9ded"
    ATTRS{driver_override}=="(null)"
    ATTRS{enable}=="1"
    ATTRS{consistent_dma_mask_bits}=="64"

  looking at parent device '/devices/pci0000:00':
    KERNELS=="pci0000:00"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{waiting_for_supplier}=="0"
```



### Luos gates
This is more anoying since the 3 gates have the same idVendor and idProduct. They can be differenciated by their serial:

```
reachy@reachy:~/reachy_ws/src/rplidar_ros/launch$ udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB0) | grep serial
    SUBSYSTEMS=="usb-serial"
    ATTRS{serial}=="D3096WZQ"
    ATTRS{serial}=="0000:00:14.0"

reachy@reachy:~/reachy_ws/src/rplidar_ros/launch$ udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB1) | grep serial
    SUBSYSTEMS=="usb-serial"
    ATTRS{serial}=="D3096X0S"
    ATTRS{serial}=="0000:00:14.0"

reachy@reachy:~/reachy_ws/src/rplidar_ros/launch$ udevadm info -a -p $(udevadm info -q path -n /dev/ttyUSB2) | grep serial
    SUBSYSTEMS=="usb-serial"
    ATTRS{serial}=="D307RR2E"
    ATTRS{serial}=="0000:00:14.0"
```
=> Here the 3 serial numbers are: D3096WZQ, D3096X0S, D307RR2E