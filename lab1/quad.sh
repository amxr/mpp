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

# just 1 thread to run on
export OMP_NUM_THREADS=1

# GNU no-opt
echo GNU no-opt
gcc -O0 quad.c func1.c  -lm
time ./a.out
echo '-------'

# GNU opt
echo GNU opt
gcc -O3 quad.c func1.c  -lm
time ./a.out
echo '-------'

# INTEL no-opt
echo INTEL no-opt
icc -O0 quad.c func1.c
time ./a.out
echo '-------'

# Intel opt
echo INTEL opt
icc -O3 quad.c func1.c
time ./a.out
echo '-------'

# Intel, no opt, OpenMP
echo -n INTEL no-Opt with OpenMP parallelisation
icc -O0 -qopenmp omp_quad.c func1.c
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_DYNAMIC=FALSE
export OMP_PROC_BIND=TRUE
echo \ \($OMP_NUM_THREADS threads\)
time ./a.out
echo '-------'

# Intel,  opt, OpenMP
echo -n INTEL opt with OpenMP parallelisation
icc -O3 -qopenmp omp_quad.c func1.c
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OMP_DYNAMIC=FALSE
export OMP_PROC_BIND=TRUE
echo \ \($OMP_NUM_THREADS threads\)
time ./a.out
echo '-------'
