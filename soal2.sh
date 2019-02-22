#!/bin/bash
echo "== A =="
hasilA=`awk -F ',' '{if($7 == "2012") x[$1]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F "," 'NR==1{print $1}'`
echo $hasilA

echo "== B =="
hasilB1=`awk -F ',' -v A="$hasilA" '{if($1 == 'A' && $7 == "2012") x[$4]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F "," 'NR==1{print $1}'` 
echo $hasilB1

hasilB2=`awk -F ',' -v B="$hasilA" '{if($1 == 'B' && $7 == "2012") x[$4]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F "," 'NR==2{print $1}'`
echo $hasilB2

hasilB3=`awk -F ',' -v C="$hasilA" '{if($1 == 'C' && $7 == "2012") x[$4]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F "," 'NR==3{print $1}'`
echo $hasilB3

echo "== C(a) =="
awk -F ',' -v X="$hasilB1" -v U1="$hasilA" '{if($4 == 'X' && $1 == 'U1' && $7 == "2012") x[$6]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F ',' 'NR<4{print $1}'
echo "== C(b) =="
awk -F ',' -v Y="$hasilB2" -v U2="$hasilA" '{if($4 == 'Y' && $1 == 'U2' && $7 == "2012") x[$6]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F ',' 'NR<4{print $1}' 
echo "== C(c) =="
awk -F ',' -v Z="$hasilB3" -v U3="$hasilA" '{if($4 == 'Z' && $1 == 'U3' && $7 == "2012") x[$6]+=$10} END {for(temp in x) {print temp "," x[temp]}}' WA_Sales_Products_2012-14.csv | sort -t, -nrk2 | awk -F ',' 'NR<4{print $1}'
