#!/usr/bin/env bash

echo HELLO WORLD
j=4

# psd_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/analyze_data/PSD_filt_calc_full.py"
psd_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/analyze_data/PSD_calc_full.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_psd{1..8}.txt )

if [ $j -eq 0 ]
then
min_depth=(13)
max_depth=(32)
elif [ $j -eq 2 ]
then
min_depth=(1 65)
max_depth=(64 129)
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
min_depth=(1  22  43  64  85 106)
max_depth=(23  44  65  86 107 129)
elif [ $j -eq 8 ]
then
min_depth=(1 17 33 49 65 81 97 113)
max_depth=(16 32 48 64 80 96 112 129)
fi

for ((i=0;i<${#min_depth[@]};i++))
do
	echo FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${psd_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	sleep 20s
done

wait

echo BYE BYE
