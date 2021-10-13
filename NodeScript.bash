#!/bin/bash

j=20

if [ $j -eq 1 ]
then
min_depths=(1)
max_depths=(129)
elif [ $j -eq 4 ]
then
min_depths=(1 33 65 97)
max_depths=(32 64 96 129)
elif [ $j -eq 5 ]
then
min_depths=(1 26 52 78 104)
max_depths=(25 51 77 103 129)
elif [ $j -eq 8 ]
then
min_depths=(1 17 33 49 65 81 97 113)
max_depths=(16 32 48 64 80 96 112 129)
elif [ $j -eq 17 ]
then
min_depths=(1 8 16 23 31 38 46 54 61 69 76 84 92 99 107 114 122)
max_depths=(7 15 22 30 37 45 53 60 68 75 83 91 98 106 113 121 129)
elif [ $j -eq 20 ]
then
min_depths=(1 7 13 20 26 33 39 46 52 59 65 71 78 84 91 97 104 110 117 123)
max_depths=(6 12 19 25 32 38 45 51 58 64 70 77 83 90 96 103 109 116 122 129)
elif [ $j -eq 24 ]
then
min_depths=(1 6 11 17 22 27 33 38 44 49 54 60 65 70 76 81 87 92 97 103 108 113 119 124)
max_depths=(5 10 16 21 26 32 37 43 48 53 59 64 69 75 80 86 91 96 102 107 112 118 123 129)
elif [ $j -eq 40 ]
then
min_depths=(1 4 7 10 13 17 20 23 26 30 33 36 39 42 46 49 52 55 59 62 65 68 71 75 78 81 84 88 91 94 97 100 104 107 110 113 117 120 123 126)
max_depths=(3 6 9 12 16 19 22 25 29 32 35 38 41 45 48 51 54 58 61 64 67 70 74 77 80 83 87 90 93 96 99 103 106 109 112 116 119 122 125 129)
fi

for ((i=0;i<${#min_depths[@]};i++))
do
#	qsub -v min_depth="${min_depths[$i]}",max_depth="${max_depths[$i]}",ind="$i" /analysis/michalshaham/BashScripts/TestNode.sh
	qsub -v min_depth="${min_depths[$i]}",max_depth="${max_depths[$i]}",ind="$i" /analysis/michalshaham/BashScripts/SpectralFluxOneNode.sh
	# echo DONE: ${min_depths[$i]} ${max_depths[$i]};
sleep 60s
done
wait

echo DONE


