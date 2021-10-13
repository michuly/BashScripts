#!/usr/bin/env bash

echo HELLO WORLD

filter_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"
fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/try_output_filter{1..8}.txt )


for ((i=0;i<${#output_files[@]};i++))
do
	echo TRY: $i;
	echo ${output_files[$i]};
	python ${filter_script} $i &
#	python ${filter_script} $i &> ${output_files[$i]} &
	echo DONE TRYING: ${min_depth[$i]} ${max_depth[$i]};
done

wait

output_files=( /atlantic/michalshaham/Data/OutputFiles/try_output_flux{1..5}.txt )

for ((i=0;i<${#output_files[@]};i++))
do
	echo TRY: $i;
	echo ${output_files[$i]};
	python ${fluxes_script} $i &
#	python ${fluxes_script} $i &> ${output_files[$i]} &
	echo DONE TRYING: ${min_depth[$i]} ${max_depth[$i]};
done

wait

echo BYE BYE
