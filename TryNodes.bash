#!/bin/bash
#
#PBS -N michal
#PBS -m abe
#PBS -l walltime=24:00:00
#PBS -j oe
#PBS -l nodes=compute-0-16:ppn=2

hostname
cd $PBS_O_WORKDIR
echo $PBS_O_WORKDIR

module load mpi/openmpi-4.0.0-IB
module load miniconda/miniconda3-4.7.12-environmentally
###module load netcdf-c-4.7.3_intel_IB
conda activate /home/apps/dedalus

echo $PATH
echo $PBS_O_PATH

echo HELLO WORLD

script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/analyze_data/try_bash.py"

python3 ${script} ${min_depth[$i]} ${max_depth[$i]} &> ${PBS_JOBID}.logfile.test

echo BYE BYE
