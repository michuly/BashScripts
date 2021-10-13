#!/usr/bin/env bash

echo HELLO WORLD

filter_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/calc_data/filtering_data.py"
fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/analyze_data/Flx_calc_full.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_filter{1..8}.txt )
min_depth=(1 17 33 49 65 81 97 113)
max_depth=(16 32 48 64 80 96 112 129)

for ((i=0;i<${#min_depth[@]};i++))
do
	echo FILTERING: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${filter_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FILTERING: ${min_depth[$i]} ${max_depth[$i]};
done

wait

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_flux{1..8}.txt )
# min_depth=(1 20 38 56 75 93 111)
# max_depth=(19 37 55 74 92 110 129)
min_depth=(1 90)
max_depth=(89 129)

for ((i=0;i<${#min_depth[@]};i++))
do
	echo FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${fluxes_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FLUXES: ${min_depth[$i]} ${max_depth[$i]};
done

wait

echo BYE BYE
