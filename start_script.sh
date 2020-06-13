#!/bin/bash

server=$1
default_server=1.15.2
dir=/home/billiam/Minecraft-Server

# If no command line arg is passed
if [[ $1 == "" ]]
then
    server=$default_server
fi

cd $dir

# Set server status to ONLINE
echo 'ONLINE' >> ./SERVER_STATUS

# Start server
java -Xmx1024M -Xms1024M -jar ./${server}-server.jar nogui

# Prompt for next status
echo 'What do you want the next status to be?'
read status
echo $status >> ./SERVER_STATUS
