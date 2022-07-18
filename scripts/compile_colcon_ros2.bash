#!/bin/bash
# Ca ça marche mais je ne comprends même pas comment c'est possible sans sourcer l'underlay :
# env -i colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release
# Je garde ça, a mon avis ça marche pas comme je pense non plus, mais au moins j'ai l'impression de comprendre :
env -i HOME="$HOME" bash -l -c "printenv; source /opt/ros/foxy/setup.bash; colcon build --symlink-install --cmake-args -DCMAKE_BUILD_TYPE=Release"