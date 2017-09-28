#!/bin/bash
shopt -s extglob

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m'

tabulate=$(curl www.kpdnkk.gov.my/kpdnkk/harga-minyak-2017/ 2>/dev/null|grep "\#cccccc\;\">"|awk -F "\>" {'print $2'} 2>/dev/null|cut -d "<" -f1)

declare -a minyak=(`printf "$tabulate\n"|tail -n 4`)

echo '-----------------------------------------------------------' 
printf "HARGA MINYAK PETROL RON95, RON97, DIESEL SEMASA DI MALAYSIA\n"
echo '-----------------------------------------------------------' 
printf "${minyak[0]} ${minyak[1]} ${minyak[2]} ${minyak[3]} ${minyak[4]}\n" 
printf "RON97\tRM${minyak[5]}\n"
printf "RON95\tRM${minyak[6]}\n"
printf "DIESEL\tRM${minyak[7]}\n"
echo '-----------------------------------------------------------' 
printf "\n"
printf "PERBANDINGAN DENGAN MINGGU LEPAS (tanda negatif bermaksud harga semasa lebih rendah)\n"
echo '-----------------------------------------------------------' 

declare -a minyaklama=(`printf "$tabulate\n"|tail -n 7`)

bezaron97=$(echo "scale=2;${minyak[5]}-${minyaklama[0]}"|bc)
bezaron95=$(echo "scale=2;${minyak[6]}-${minyaklama[1]}"|bc)
bezadiesel=$(echo "scale=2;${minyak[7]}-${minyaklama[2]}"|bc)


if [[ $(bc -l <<<  "${minyak[5]} <=  ${minyaklama[0]}"  ) -eq 1 ]]; then
	printf "Beza RON97 RM ${GREEN}$bezaron97${NC} (sama/makin murah)\n"
else
	printf "Beza RON97 RM ${RED}$bezaron97${NC} (makin mahal)\n"
fi

if [[ $(bc -l <<< "${minyak[6]} <= ${minyaklama[1]}" ) -eq 1 ]]; then
	printf "Beza RON95 RM ${GREEN}$bezaron95${NC} (sama/makin murah)\n"
else
	printf "Beza RON95 RM ${RED}$bezaron95${NC} (makin mahal)\n"
fi

if [[ $(bc -l <<< "${minyak[7]} <= ${minyaklama[2]}" ) -eq 1 ]]; then
	printf "Beza DIESEL RM ${GREEN}$bezadiesel${NC} (sama/akin murah)\n"
else	
	printf "Beza DIESEL RM ${RED}$bezadiesel${NC} (makin mahal)\n"
fi

