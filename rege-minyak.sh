#!/bin/bash

tabulate=$(curl www.kpdnkk.gov.my/kpdnkk/harga-minyak-2017/ 2>/dev/null|grep "\#cccccc\;\">"|awk -F "\>" {'print $2'} 2>/dev/null|cut -d "<" -f1)

declare -a minyak=(`printf "$tabulate\n"|tail -n 4`)

echo '-----------------------------------------------------------' 
printf "HARGA MINYAK PETROL RON95, RON97, DIESEL SEMASA DI MALAYSIA\n"
echo '-----------------------------------------------------------' 
printf "${minyak[0]} ${minyak[1]} ${minyak[2]} ${minyak[3]} ${minyak[4]} ${minyak[5]}\n" 
printf "RON97\tRM${minyak[6]}\n"
printf "RON95\tRM${minyak[7]}\n"
printf "DIESEL\tRM${minyak[8]}\n"
echo '-----------------------------------------------------------' 
