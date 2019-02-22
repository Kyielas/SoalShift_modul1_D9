#!/bin/bash
i=1
x=1

while [ $i -ne 0 ]
do
	if [ -f /home/kyielas/Password/pass$x.txt  ]
	then x=$((x + 1))
	else
		`tr -cd '[:alnum:]' < /dev/urandom | fold -w12 | head -1 > /home/kyielas/Password/pass$x.txt`
		i=0
	fi
done
