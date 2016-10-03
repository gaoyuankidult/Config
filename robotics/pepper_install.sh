#################################################################################
# Coding conventions
#
# - Prefer portability, but don't sacrifice security and whitespace awareness
#   to it.
#
# - Prefer builtins over external commands.
#
# - But, use fast external commands to process very large inputs.
#
# - Avoid unnecessary subshells and pipelines.
#
# - Don't preoptimize.
#
# - Learn the rules of quoting. Then, use quotes.
#
# - Use functions to improve readability and control scope.
# 
# - Don't give scripts silly file extensions.
#
# - Never change directory without checking that it worked.
#
# - Eschew hobgoblins
#
#
# "A foolish consistency is the hobgoblin of little minds, adored by little
#  statesmen and philosophers and divines."
#
#  – Ralph Waldo Emerson
#
#
################################################################################

# require sudo right
if [[ `lsb_release -rs` != "14.04" ]] 
then
    echo "Please ensure Ubuntu version is 14.04 trusty, quiting..."
	exit 1
fi

# install addtional ros packages
sudo apt-get install ros-indigo-driver-base ros-indigo-move-base-msgs ros-indigo-octomap ros-indigo-octomap-msgs ros-indigo-humanoid-msgs ros-indigo-humanoid-nav-msgs ros-indigo-camera-info-manager ros-indigo-camera-info-manager-py

# install rospkg 
git clone git://github.com/ros/rospkg.git
cd rospkg
python setup.py install --user
cd ..
rm -rf rospkg

# install naoqi
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
git clone https://github.com/ros-naoqi/naoqi_driver.git
rosdep install -i -y --from-paths ./naoqi_driver
source /opt/ros/indigo/setup.sh
cd ../ && catkin_make

# install ros pepper 
sudo apt-get install ros-indigo-pepper-.*

# check http://wiki.ros.org/pepper/Tutorials for following command
