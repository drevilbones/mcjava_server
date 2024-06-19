#!/bin/bash

mc_comp=`pwd`
mc_data="/opt/minecraft/data_java/"
mc_backup="/big/Archives/mc_backups/"
maxbackups=30

mc_send () { sudo docker exec mcjava rcon-cli $1; }

mc_send "say §6Server going down for backups in §415 minutes!"
sleep 5m
mc_send "say §6Server going down for backups in §410 minutes!"
sleep 5m
mc_send "say §6Server going down for backups in §45 minutes!"
sleep 5m

mc_send "say §6Server going down for backups §4right now! Byebye!"
sleep 5

cd $mc_comp
sudo docker compose down
cd $mc_data
fname="mc_$(date +%s).tgz"
sudo tar czvf $fname world
cd $mc_comp
sudo docker compose up -d

sudo mv $mc_data/$fname $mc_backup

cd $mc_backup
numbackups=$(ls | wc -l)
if [[ numbackups -gt maxbackups ]]
then
	ls -1t | tail -n 1 | xargs sudo rm -f
fi

