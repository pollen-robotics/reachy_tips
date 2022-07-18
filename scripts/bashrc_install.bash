
echo "" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "# Virutalenvwrapper settings" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenv" >> ~/.bashrc
echo "VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo ". /home/reachy/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo "" >> ~/.bashrc

echo "# Adding some useful aliases" >> ~/.bashrc
echo "source ~/reachy_tips/scripts/custom_aliases" >> ~/.bashrc
echo "" >> ~/.bashrc

echo "# ROS configuration" >> ~/.bashrc
echo "source ~/reachy_tips/config/reachy_ros_config" >> ~/.bashrc



