#!/usr/bin/env bash

echo HELLO WORLD

j=0

if [ $j -eq 0 ]
then 
filter=(16 16 16 16)
exp=('Stochastic' 'Steady' 'Stochastic' 'Steady')
helm_domain=('LF' 'LF' 'HF' 'HF')
elif [ $j -eq 12 ]
then 
filter=(14)
exp=('Steady')
fi

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_netcdf{6..10}.txt )
	
for ((i=0;i<${#filter[@]};i++))
do
	echo NETCDF: ${filter[$i]} ${exp[$i]};
	echo ${output_files[$i]};
#	echo "/atlantic/michalshaham/Data/Filtered/${exp[i]}/fw${filter[i]}/*.nc"
#	nc3to4z /atlantic/michalshaham/Data/Filtered/${exp[i]}/fw${filter[i]}/*.nc &> ${output_files[$i]} &
	nc3to4z /atlantic/michalshaham/Data/Helmholtz/${exp[i]}/fw${filter[i]}_${helm_domain[i]}/*.nc &> ${output_files[$i]} &
	echo "/atlantic/michalshaham/Data/Helmholtz/${exp[i]}/fw${filter[i]}/*.nc"
	echo DONE NETCDF: ${filter[$i]} ${exp[$i]};
	sleep 10s
done

wait

echo BYE BYE
