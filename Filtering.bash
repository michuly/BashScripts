#!/usr/bin/env bash

echo HELLO WORLD

filter_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/calc_data/Filtering_data.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_filter{1..8}.txt )
min_depth=(1 33 65 97)
max_depth=(32 64 96 129)

for ((i=0;i<${#min_depth[@]};i++))
do
	echo FILTERING: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${filter_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FILTERING: ${min_depth[$i]} ${max_depth[$i]};
done

wait

echo BYE BYE
