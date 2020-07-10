#!/bin/bash

server=$1
default_server=1.16.1
dir=/home/billiam/Minecraft-Server
ip="24.224.83.69"

status_tag="STATUS: "
version_tag="VERSION: "
ip_tag="IP: "
crash_message="STATUS: Unexpectedly closed
  If this message does not go away shortly, the server has likely crashed.
  If that is the case, please notify @Mario3Jump."

# If no command line arg is passed
if [[ $1 == "" ]]
then
    server=$default_server
fi

cd $dir

echo ${status_tag}'ONLINE' > ./SERVER_STATUS
echo ${version_tag}${server} >> ./SERVER_STATUS
echo ${ip_tag}${ip} >> ./SERVER_STATUS

# Start server
java -Xmx1024M -Xms1024M -jar ./${server}-server.jar nogui

# Place holder on the condition of a crash
echo $crash_message > ./SERVER_STATUS

# Prompt for next status
echo 'What do you want the next status to be?'
read status
echo ${status_tag}${status} > ./SERVER_STATUS
