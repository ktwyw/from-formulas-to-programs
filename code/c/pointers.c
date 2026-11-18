/* Pointers, arrays and pass-by-address in C. */
#include <stdio.h>

/* Swap two doubles: the function receives their ADDRESSES. */
void swap(double *a, double *b)
{
    double tmp = *a;   /* *a = "the value stored at address a" */
    *a = *b;
    *b = tmp;
}

/* An array argument decays to a pointer to its first element,
   so the length must be passed separately. */
double mean(const double *x, int n)
{
    double s = 0.0;
    for (int i = 0; i < n; i++)
        s += x[i];          /* x[i] is the same as *(x + i) */
    return s / n;
}

int main(void)
{
    double p = 1.5, q = 2.5;
    swap(&p, &q);           /* &p = "the address of p" */
    printf("after swap: p = %.1f, q = %.1f\n", p, q);

    double loads[] = {12.6, 14.0, 13.2, 15.8, 11.9};
    int n = sizeof loads / sizeof loads[0];
    printf("n = %d, mean load = %.2f kN\n", n, mean(loads, n));

    double *ptr = loads;    /* ptr points to loads[0] */
    printf("loads[2] = %.1f = *(ptr + 2) = %.1f\n", loads[2], *(ptr + 2));
    printf("address of loads[0]: %p, of loads[1]: %p\n",
           (void *) &loads[0], (void *) &loads[1]);
    return 0;
}
