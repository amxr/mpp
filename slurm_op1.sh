#!/bin/bash -l

# load modules
module load compilers/intel/2019u5

# parallel using OpenMP
SRC=op1_omp.c
MAIN=main_op1.c
EXE=${SRC}.exe
echo compiling $SRC to $EXE
icc -qopenmp -std=c99 -O0 $SRC $MAIN -o $EXE && \
(
for THREADS in 1 2 4 8 16 32
do
export OMP_NUM_THREADS=$THREADS # if '-c' not used then default to 1
    echo using ${OMP_NUM_THREADS} OpenMP threads
    # run 5 times
    time ./${EXE};echo
    time ./${EXE};echo
    time ./${EXE};echo
    time ./${EXE};echo
    time ./${EXE};echo
done
) \
|| echo $SRC did not built to $EXE
