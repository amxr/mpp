#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

void op2(float *a_vec, int m, int n, int p, float *b_vec, float *c_vec)
{
    float(*a)[n] = (float(*)[n])a_vec;
    float(*b)[p] = (float(*)[p])b_vec;
    float(*c)[p] = (float(*)[p])c_vec;

    for (int k = 0; k < m; k++)
    {
        for (int i = 0; i < p; i++)
        {
            int val = 0;
            for (int j = 0; j < n; j++)
            {
                val += a[k][j] * b[j][i];
            }
            c[k][i] = val;
            val = 0;
        }
    }
}