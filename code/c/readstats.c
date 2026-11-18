/* Read numbers from a file into a growing array; compute mean and std. */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    double mean;
    double std;
    double min;
    double max;
} Stats;

Stats compute_stats(const double *x, size_t n)
{
    Stats s = {0.0, 0.0, x[0], x[0]};
    for (size_t i = 0; i < n; i++) {
        s.mean += x[i];
        if (x[i] < s.min) s.min = x[i];
        if (x[i] > s.max) s.max = x[i];
    }
    s.mean /= n;
    for (size_t i = 0; i < n; i++)
        s.std += (x[i] - s.mean) * (x[i] - s.mean);
    s.std = sqrt(s.std / (n - 1));
    return s;
}

int main(int argc, char *argv[])
{
    const char *filename = (argc > 1) ? argv[1] : "../data/yield.txt";
    FILE *f = fopen(filename, "r");
    if (f == NULL) {
        fprintf(stderr, "Cannot open %s\n", filename);
        return EXIT_FAILURE;
    }

    size_t n = 0, capacity = 4;
    double *x = malloc(capacity * sizeof *x);   /* memory on the heap */
    double value;
    while (fscanf(f, "%lf", &value) == 1) {
        if (n == capacity) {                    /* full: double the size */
            capacity *= 2;
            double *bigger = realloc(x, capacity * sizeof *x);
            if (bigger == NULL) { free(x); fclose(f); return EXIT_FAILURE; }
            x = bigger;
        }
        x[n++] = value;
    }
    fclose(f);

    Stats s = compute_stats(x, n);
    printf("n = %zu\nmean = %.2f MPa\nstd  = %.2f MPa\nrange = [%.1f, %.1f] MPa\n",
           n, s.mean, s.std, s.min, s.max);

    free(x);                                    /* give the memory back */
    return EXIT_SUCCESS;
}
