#!/bin/bash

property=$1
default_property="SURVIVAL"
server=$2
default_server=1.16.3
dir=/home/billiam/Minecraft-Server
ip="24.224.83.69"

cd $dir

status_tag="STATUS: "
version_tag="VERSION: "
ip_tag="IP: "
crash_message="STATUS: Unexpectedly closed
    If this message does not go away shortly, the server has likely crashed.
    If that is the case, please notify @Mario3Jump."

do_uhc () {
    rm -r $dir/UHC
    echo "Deploying UHC world ($1 mode)."
    cp $dir/properties/UHC/server.properties $dir/
    mkdir $dir/UHC
    mkdir $dir/UHC/datapacks
    cp -r $dir/properties/UHC/UHC-datapacks/uhc_$1 $dir/UHC/datapacks
    echo 'Do speed mode?'
    read speedmode
    case $speedmode in
        "y")
            cp -r $dir/properties/UHC/UHC-datapacks/uhc_speed $dir/UHC/datapacks
            echo 'Speed mode active.'
        ;;
        *)
            echo 'Speed mode cancelled.'
    esac
}

# If no command line arg is passed
if [[ $1 == "" ]]
then
    echo "No property supplied. Assuming $default_property."
    property=$default_property
fi
if [[ $2 == "" ]]
then
    echo "No server verion supplied. Assuming $default_server."
    server=$default_server
fi

case $property in
    "LOBBY")
        rm -r $dir/LOBBY
        echo 'Deploying lobby world.'
        cp $dir/properties/Lobby/server.properties $dir/
    ;;
    "SURVIVAL")
        echo 'Deploying survival world.'
        cp $dir/properties/Survival/server.properties $dir/
    ;;
    "UHC_SOLO")
        do_uhc "solo"
    ;;
    "UHC_TEAMS")
        do_uhc "teams"
    ;;
    *)
        echo "ERROR: Expected LOBBY, SURVIVAL, UHC_SOLO, UHC_TEAMS, got $property."
        exit 1
esac

echo ${status_tag}'ONLINE' > $dir/SERVER_STATUS
echo ${version_tag}${server} >> $dir/SERVER_STATUS
echo ${ip_tag}${ip} >> $dir/SERVER_STATUS

# Start server
java -Xmx1024M -Xms1024M -jar ./${server}-server.jar nogui

# Place holder on the condition of a crash
echo $crash_message > $dir/SERVER_STATUS

# Prompt for next status
echo 'What do you want the next status to be?'
read status
echo ${status_tag}${status} > $dir/SERVER_STATUS
