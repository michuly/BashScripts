#!/bin/bash
#
#PBS -N michal
#PBS -m abe
#PBS -l walltime=48:00:00
#PBS -j oe
#PBS -l nodes=compute-0-16:ppn=8

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

# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/analyze_data/Flx_calc_decompositions.py"
fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/calc_data/Helmholz_data.py"
# fluxes_script="/analysis/michalshaham/PythonProjects/Oceanography/scripts/try_bash.py"

output_files=( /analysis/michalshaham/BashScripts/Output_files/${PBS_JOBID}.logfile{1..40}.txt )

j=8

if [ $j -eq 1 ]
then
min_depth=(1)
max_depth=(129)
elif [ $j -eq 4 ]
then
min_depth=(1 33 65 97)
max_depth=(32 64 96 129)
elif [ $j -eq 5 ]
then
min_depth=(1 26 52 78 104)
max_depth=(25 51 77 103 129)
elif [ $j -eq 8 ]
then
min_depth=(1 17 33 49 65 81 97 113)
max_depth=(16 32 48 64 80 96 112 129)
elif [ $j -eq 17 ]
then
min_depth=(1 8 16 23 31 38 46 54 61 69 76 84 92 99 107 114 122)
max_depth=(7 15 22 30 37 45 53 60 68 75 83 91 98 106 113 121 129)
elif [ $j -eq 20 ]
then
min_depth=(1 7 13 20 26 33 39 46 52 59 65 71 78 84 91 97 104 110 117 123)
max_depth=(6 12 19 25 32 38 45 51 58 64 70 77 83 90 96 103 109 116 122 129)
elif [ $j -eq 24 ]
then
min_depth=(1 6 11 17 22 27 33 38 44 49 54 60 65 70 76 81 87 92 97 103 108 113 119 124)
max_depth=(5 10 16 21 26 32 37 43 48 53 59 64 69 75 80 86 91 96 102 107 112 118 123 129)
elif [ $j -eq 30 ]
then
min_depth=(1 5 9 13 18 22 26 31 35 39 44 48 52 56 61 65 69 74 78 82 87 91 95 99 104 108 112 117 121 125)
max_depth=(4 8 12 17 21 25 30 34 38 43 47 51 55 60 64 68 73 77 81 86 90 94 98 103 107 111 116 120 124 129)
elif [ $j -eq 36 ]
then
min_depth=(1 4 8 11 15 18 22 26 29 33 36 40 44 47 51 54 58 61 65 69 72 76 79 83 87 90 94 97 101 104 108 112 115 119 122 126)
max_depth=(3 7 10 14 17 21 25 28 32 35 39 43 46 50 53 57 60 64 68 71 75 78 82 86 89 93 96 100 103 107 111 114 118 121 125 129)
elif [ $j -eq 40 ]
then
min_depth=(1 4 7 10 13 17 20 23 26 30 33 36 39 42 46 49 52 55 59 62 65 68 71 75 78 81 84 88 91 94 97 100 104 107 110 113 117 120 123 126)
max_depth=(3 6 9 12 16 19 22 25 29 32 35 38 41 45 48 51 54 58 61 64 67 70 74 77 80 83 87 90 93 96 99 103 106 109 112 116 119 122 125 129)
fi


# for ((i=0;i<${#min_depth[@]};i++))
# for ((i=0;i<12;i++))
# for ((i=12;i<24;i++))
for ((i=0;i<${#min_depth[@]};i++))
do
	echo FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	echo ${output_files[$i]};
	python ${fluxes_script} ${min_depth[$i]} ${max_depth[$i]} &> ${output_files[$i]} &
	echo DONE FLUXES: ${min_depth[$i]} ${max_depth[$i]};
	sleep 30s
done

wait


# python3 ${fluxes_script} ${i} ${j} &> ${PBS_JOBID}.logfile.test


echo BYE BYE
