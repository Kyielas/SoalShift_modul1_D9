#!/bin/bash

read dekrip

upperU=ABCDEFGHIJKLMNOPQRSTUVWXYZ
lowerU=abcdefghijklmnopqrstuvwxyz
jam=${dekrip:0:2}
x=$jam

eupper=($(echo ${upperU[@]})$(echo ${upperU[@]}))
elower=($(echo ${lowerU[@]})$(echo ${lowerU[@]}))

base=($(echo ${upperU[@]})$(echo ${lowerU[@]}))
update1=$(echo $upperU | tr "${upperU:0:26}" "${eupper:${x}:26}")
update2=$(echo $lowerU | tr "${lowerU:0:26}" "${elower:${x}:26}")
res=($(echo ${update1[@]})$(echo ${update2[@]}))

format=`date +"%H:%M %d-%m-%Y"`
< "$dekrip" > "$dekrip t" tr "$base" "$res"
