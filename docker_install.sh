echo "Ensure that yoru kernel version is greater than 3.10 [ENTER]:"
read year

sudo apt-get update

# install prerequisite
sudo apt-get install apt-transport-https ca-certificates
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual

# add a new GPG key
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "Ensure that your repo matches with your ubuntu version 3.10 [ENTER]:"
read year

# add docker source to repo
REPO="deb https://apt.dockerproject.org/repo ubuntu-trusty main"
echo $REPO | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update

# start to install docker
sudo apt-get install docker-engine

# test docker
sudo service docker start
sudo docker run hello-world

# added current user to docker group
sudo groupadd docker
unset DOCKER_HOST
docker run hello-world
