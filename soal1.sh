#!/bin/bash

list=`ls ~/nature | grep "[.]jpg$"`

for decode in $list
do
	`base64 -d ~/nature/"$decode" | xxd -r > ~/nature/"dc$decode.jpg"`
done
