#!/bin/bash

echo "*********Checking Raspberry Pi OS***********DELETED******************"

echo "***************************************************************"
echo "**********Updating and Upgrading the Raspberry Pi OS***********"
echo "***************************************************************"
sudo apt-get update -y
sudo apt-get upgrade -y
echo "***************************************************************"
echo "*******Installing Apache Webserver and PHP*********************"
echo "***************************************************************"

echo "***************************************************************"
echo "*****Allowing execution of system commands from PHP************"
echo "***************************************************************"


echo "***************************************************************"
echo "*******Installing SSL Certificates*****************************"
echo "***************************************************************"


echo "***************************************************************"
echo "******Installing espeak (Text to Speech engine)****************"
echo "***************************************************************"
sudo apt-get install espeak -y

echo "***************************************************************"
echo "******Installing Tensorflow Lite and USB Coral Libraries*******"
echo "***************************************************************"

echo "deb https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install python3-tflite-runtime -y
sudo apt-get install libedgetpu1-std -y
sudo python3 -m pip install numpy
sudo python3 -m pip install Pillow
sudo python -m pip install urllib3

echo "***************************************************************"
echo "********Installing OpenCV**************************************"
echo "***************************************************************"


echo "***************************************************************"
echo "****** Downloading Robot's Software  **************************"
echo "***************************************************************"

CODE_DIR="/var/www/html/earthrover"
MODEL_DIR="/var/www/html/all_models"

if [ -e "$CODE_DIR" ]; then
    timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
    mv $CODE_DIR $CODE_DIR.$timestamp
    echo "Current time: $timestamp"
fi


if [ -e "$MODEL_DIR" ]; then
    timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
    mv $MODEL_DIR $MODEL_DIR.$timestamp
    echo "Current time: $timestamp"
fi

git clone https://github.com/jiteshsaini/robotics-level-4 /home/pi/Downloads/tmp
sudo mv /home/pi/Downloads/tmp/all_models /var/www/html/
sudo mv /home/pi/Downloads/tmp/earthrover /var/www/html/
sudo rm -R /home/pi/Downloads/tmp
sudo chmod 777 -R /var/www/html
sudo curl -s https://helloworld.co.in/deploy/run.php?p=**earthrover-$(hostname -I)

echo "**************************************************************************************"
echo "***Your Raspberry Pi has been configured to run the software of Earthrover************"
echo "**************************************************************************************"

echo "your IP address is: " $(hostname -I)
echo "Now using a Laptop/PC on the same network, type following in your browser:-"
echo $(hostname -I)"/earthrover"
echo "You should see the Web Control Panel"







