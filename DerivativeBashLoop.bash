#!/usr/bin/env bash

echo HELLO WORLD

helm_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/calc_data/Derivative_z.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/output_deriv{1..8}.txt )


experiments=('Stochastic')
filter_widths=(16)
freq_domains=('LF')


l=0
for ((i=0;i<${#experiments[@]};i++))
do
for ((j=0;j<${#filter_widths[@]};j++))
do
for ((k=0;k<${#freq_domains[@]};k++))
do
	echo Derivatives: ${experiments[$i]} ${filter_widths[$j]} ${freq_domains[$k]};
	echo ${output_files[$l]};
	python ${helm_script} ${experiments[$i]} ${filter_widths[$j]} ${freq_domains[$k]} &> ${output_files[$l]} &
	l=$l+1
	echo DONE DERIVATIVES: ${experiments[$i]} ${filter_widths[$j]} ${freq_domains[$k]};
done
done
done

wait

echo BYE BYE
