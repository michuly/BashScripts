#!/usr/bin/env bash

echo HELLO WORLD

j=10

fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/analyze_data/Flx_calc_decompositions.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

if [ $j -eq 0 ]
then 
min_depth=(1 3 10 13 19 40 91 93 107 117)
max_depth=(2 5 12 15 21 42 92 95 121 119)
# min_depth=(115 117 119)
# max_depth=(116 118 121)
elif [ $j -eq 1 ]
then
min_depth=(1)
max_depth=(129)
elif [ $j -eq 2 ]
then
min_depth=(1 64)
max_depth=(63 129)
elif [ $j -eq 4 ]
then
min_depth=(1 33 65 97)
max_depth=(32 64 96 129)
elif [ $j -eq 5 ]
then
min_depth=(1 26 52 78 104)
max_depth=(25 51 77 103 129)
elif [ $j -eq 6 ]
then
min_depth=(1 22 44 65 87 108)
max_depth=(21 43 64 86 107 129)
elif [ $j -eq 7 ]
then
min_depth=(1 19 37 56 74 93 111)
max_depth=(18 36 55 73 92 110 129)
elif [ $j -eq 8 ]
then
min_depth=(1 17 33 49 65 81 97 113)
max_depth=(16 32 48 64 80 96 112 129)
elif [ $j -eq 10 ]
then
min_depth=(1 14 27 40 53 66 78 91 104 117)
max_depth=(13 26 39 52 65 77 90 103 116 129)
elif [ $j -eq 12 ]
then
min_depth=(1 11 22 33 44 55 66 77 88 99 110 120)
max_depth=(10 21 32 43 54 65 76 87 98 109 119 129)
fi

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_flux{1..20}.txt )
	
for ((i=0;i<${#min_depth[@]};i++))
do
	echo FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${fluxes_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	sleep 10s
done

wait

echo BYE BYE
