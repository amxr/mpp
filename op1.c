#include <stdio.h>
#include <math.h>

void op1(float *input_vec, int m, int n, float *filter_vec, int k, float *output_vec, int b) {
    // Define 3D arrays using pointer variables
    float(*input)[m][n] = (float(*)[m][n])input_vec;
    float(*filter)[k] = (float(*)[k])filter_vec;
    float(*output)[m][n] = (float(*)[m][n])output_vec;

    int start = floor((k - 1) / 2);
    int end = m - ceil((k - 1) / 2);

    for(int batch = 0; batch < b; batch++){
        for (int input_row = 0; input_row < m; input_row++) {
            for (int input_col = 0; input_col < n; input_col++) {
                if (input_row < start || input_col < start || input_row >= end || input_col >= end){
                    output[batch][input_row][input_col] = input[batch][input_row][input_col];
                }else{
                    float sum = 0;
                    for (int filter_row = 0; filter_row < k; filter_row++){
                        for (int filter_col = 0; filter_col < k; filter_col++){
                            int row = input_row - k / 2 + filter_row;
                            int col = input_col - k / 2 + filter_col;
                            sum += input[batch][row][col] * filter[filter_row][filter_col];
                        }
                    }
                    output[batch][input_row][input_col] = sum;
                }
            }
        }
    }
}