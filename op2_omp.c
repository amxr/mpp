#include <stdio.h>
#include <stdlib.h>
#define __USE_C99_MATH
#include <stdbool.h>
#include <omp.h>
void op2(float *a_vec, int m, int n, int p, float *b_vec, float *c_vec)
{
    float(*a)[n] = (float(*)[n])a_vec;
    float(*b)[p] = (float(*)[p])b_vec;
    float(*c)[p] = (float(*)[p])c_vec;

    int val = 0;
    int i,j,k;
    #pragma omp parallel for default(none) shared(m, n, p, a, b, c) private(i, k, j) reduction(+: val)
    for (k = 0; k < m; k++)
    {
        for (i = 0; i < p; i++)
        {
            for (j = 0; j < n; j++)
            {
                val += a[k][j] * b[j][i];
            }
            c[k][i] = val;
            val = 0;
        }
    }
}