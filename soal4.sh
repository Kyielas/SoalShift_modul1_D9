#!/bin/bash

upperU=ABCDEFGHIJKLMNOPQRSTUVWXYZ
lowerU=abcdefghijklmnopqrstuvwxyz
jam=`date +"%H"`
x=$jam

eupper=($(echo ${upperU[@]})$(echo ${upperU[@]}))
elower=($(echo ${lowerU[@]})$(echo ${lowerU[@]}))

base=($(echo ${upperU[@]})$(echo ${lowerU[@]}))
update1=$(echo $upperU | tr "${upperU:0:26}" "${eupper:${x}:26}")
update2=$(echo $lowerU | tr "${lowerU:0:26}" "${elower:${x}:26}")
res=($(echo ${update1[@]})$(echo ${update2[@]}))

format=`date +"%H:%M %d-%m-%Y"`
< /var/log/syslog > "$format" tr "$base" "$res"
