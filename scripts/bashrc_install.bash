
echo "" >> ~/.bashrc
echo "" >> ~/.bashrc
echo "# Virutalenvwrapper settings" >> ~/.bashrc
echo "export WORKON_HOME=$HOME/.virtualenvs" >> ~/.bashrc
echo "export PROJECT_HOME=/home/reachy/Devel" >> ~/.bashrc
echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> ~/.bashrc
echo "source /home/reachy/.local/bin/virtualenvwrapper.sh" >> ~/.bashrc

echo "" >> ~/.bashrc

echo "# Adding some useful aliases" >> ~/.bashrc
echo "source ~/reachy_tips/config/custom_aliases" >> ~/.bashrc
echo "" >> ~/.bashrc

echo "# ROS configuration" >> ~/.bashrc
echo "source ~/reachy_tips/config/reachy_ros_config" >> ~/.bashrc



