# Reachy tips
## Purpose
This repository is used to share any useful tips/aliases/guides/scripts that are gathered along the way, related to ROS, Reachy, Git and other development based subjects.

This started as an internal tool and was later opened as it might be useful to those who want to get their hands dirty.

## Installation
Clone this repository:
```
cd
git clone https://github.com/pollen-robotics/reachy_tips.git
```

Run the following script to have the correct ROS configuration, the virtual env configuration and some useful aliases. Do this only once as it will add lines into the ~/.bashrc file:
```
bash ~/reachy_tips/scripts/bashrc_install.bash
```
:warning: Your bashrc will now source the files [config/reachy_ros_config](config/reachy_ros_config) and [config/custom_aliases](config/custom_aliases)

## Usage
The repository is organized around 3 folders: config, scripts and tips.
We recommend to read the file '[config/custom_aliases](config/custom_aliases)' as the aliases (and most scripts) are documented there.

### USB identification and udev rules
A guide on how to identify the USB devices to create udev rules can be found in [tips/usb_identification.md](tips/usb_identification.md).

From one Reachy to another, the gates for the arms and the head do not have the same serial id, so they need to be set for each Reachy individually. To do that automagically, use the script *write_udev_rules_gates.py*.

NOTE: you need to run the script in sudo mode.

```bash
cd ~/reachy_tips/scripts
sudo python3 write_udev_rules_gates.py
```

