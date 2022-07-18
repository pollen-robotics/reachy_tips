Clone this repository and add the custom aliases in Reachy's bashrc:

```
cd
git clone https://github.com/pollen-robotics/reachy_tips.git
echo "source ~/reachy_tips/custom_aliases" >> ~/.bashrc
```

# setup "editor" mode

colb

jupytercleanr

dossiers

script qui rajoute tous les sources :
- custom_aliases
- source ros
- virtualenv

#Virutalenvwrapper settings
export WORKON_HOME=$HOME/.virtualenv
VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
. /home/reachy/.local/bin/virtualenvwrapper.sh


githooks ?

rajouter : 
lint_f8=python -m flake8 . --count --show-source --statistics


réparer view_frames