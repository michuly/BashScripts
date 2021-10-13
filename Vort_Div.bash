#!/usr/bin/env bash

echo HELLO WORLD

helm_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/vort_div_data.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_vort{1..5}.txt )
min_depth=(1 68)
max_depth=(67 129)

for ((i=0;i<${#min_depth[@]};i++))
do
	echo FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${helm_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FLUXES: ${min_depth[$i]} ${max_depth[$i]};
done

wait

echo BYE BYE
