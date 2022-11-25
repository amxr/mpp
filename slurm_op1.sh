#!/bin/bash -l

# Specify the current working directory as the location for executables/files
# This is the default setting.
#SBATCH -D ./

# Export the current environment to the compute node
# This is the default setting.
#SBATCH --export=ALL

# Specific course queue
#SBATCH -p course

# 4 cores for auto-par version
#SBATCH -c 20
#SBATCH --exclusive

# load modules
module load compilers/intel/2019u5

# parallel using openMp
SRC=op2_omp.c
MAIN=main_op2.c
EXE=${SRC}.exe
echo compiling $SRC to $EXE
icc -qopenmp -O0 $SRC $MAIN -o $EXE && \
(
# set number of threads
export OMP_NUM_THREADS=1 # if '-c' not used then default to 1
echo using ${OMP_NUM_THREADS} OpenMP threads
# run 3 times
./${EXE};echo
./${EXE};echo
./${EXE};echo

# set number of threads
export OMP_NUM_THREADS=1 # if '-c' not used then default to 1
echo using ${OMP_NUM_THREADS} OpenMP threads
# run 3 times
./${EXE};echo
./${EXE};echo
./${EXE};echo

# set number of threads
export OMP_NUM_THREADS=1 # if '-c' not used then default to 1
echo using ${OMP_NUM_THREADS} OpenMP threads
# run 3 times
./${EXE};echo
./${EXE};echo
./${EXE};echo
) \
|| echo $SRC did not built to $EXE