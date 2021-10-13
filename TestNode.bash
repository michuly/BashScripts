#!/bin/bash

echo $min_depth $max_depth $ind &> /analysis/michalshaham/BashScripts/Output_files/logfile1.txt

output_file=( /analysis/michalshaham/BashScripts/Output_files/${PBS_JOBID}.logfile{$ind}.txt )

echo $output_file
