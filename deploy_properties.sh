#!/bin/bash

dir=/home/billiam/Minecraft-Server

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

echo '[0] New Lobby'
echo '[1] Deploy Survival World'
echo '[2] New UHC World (solo mode)'
echo '[3] New UHC World (teams mode)'
read choice

case $choice in
    "0")
        rm -r $dir/LOBBY
        echo 'Deploying lobby world.'
        cp $dir/properties/Lobby/server.properties $dir/
    ;;
    "1")
        echo 'Deploying survival world.'
        cp $dir/properties/Survival/server.properties $dir/
    ;;
    "2")
        do_uhc "solo"
    ;;
    "3")
        do_uhc "teams"
    ;;
    *)
        echo 'ERROR: Not a valid choice'
esac
