#include <stdio.h>
#include <stdlib.h>
#define __USE_C99_MATH
#include <string.h>
#include <stdbool.h>
#include <math.h>

void op1(float *input_vec, int m, int n, float *filter_vec, int k, float *output_vec, int b)
{
  float(*input)[m][n] = (float(*)[m][n])input_vec;
  float(*filter)[k] = (float(*)[k])filter_vec;
  float(*output)[m][n] = (float(*)[m][n])output_vec;
  float arr[k][k];

  int b_lower = floor((k - 1) / 2);
  int b_upper = ceil((k - 1) / 2);

  int start = b_lower;
  int end = m - b_lower;

  for (int batch = 0; batch < b; batch++)
  {
    for (int i = 0; i < m; i++)
    {
      for (int j = 0; j < n; j++)
      {
        if (i < start || j < start || i >= end || j >= end)
        {
          output[batch][i][j] == input[batch][i][j];
        }
        else
        {
          output[batch][i][j] += input[batch][i][j] * filter[][]; 
        }
      }
    }
  }
}
