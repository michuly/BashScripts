#!/bin/bash
#
#PBS -N michal
#PBS -m abe
#PBS -l walltime=48:00:00
#PBS -j oe
#PBS -l nodes=compute-0-16:ppn=1

hostname
cd $PBS_O_WORKDIR
echo $PBS_O_WORKDIR

module load mpi/openmpi-4.0.0-IB
module load miniconda/miniconda3-4.7.12-environmentally
conda activate /home/apps/dedalus

echo $PATH
echo $PBS_O_PATH
which mpiexec

echo HELLO WORLD
echo $min_depth $max_depth $ind

