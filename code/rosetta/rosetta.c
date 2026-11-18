/* Three small numerical tasks: Newton's method, trapezoidal rule, statistics. */
#include <math.h>
#include <stdio.h>

typedef double (*func)(double);           /* pointer to a function double -> double */

static double cubic(double x)  { return x * x * x - 2.0 * x - 5.0; }
static double dcubic(double x) { return 3.0 * x * x - 2.0; }

static int newton(func f, func df, double *x)
{
    for (int k = 1; k <= 50; k++) {
        double step = f(*x) / df(*x);
        *x -= step;
        if (fabs(step) < 1e-12) return k;
    }
    return -1;                             /* no convergence */
}

static double trapezoid(func f, double a, double b, int n)
{
    double h = (b - a) / n;
    double s = 0.5 * (f(a) + f(b));
    for (int i = 1; i < n; i++)
        s += f(a + i * h);
    return s * h;
}

int main(void)
{
    double x = 2.0;
    int iters = newton(cubic, dcubic, &x);
    if (iters < 0) { fprintf(stderr, "no convergence\n"); return 1; }
    printf("Newton:     root = %.15f (%d iterations)\n", x, iters);
    printf("Trapezoid:  integral = %.15f (n = 100)\n", trapezoid(sin, 0.0, M_PI, 100));

    double data[1000], sum = 0.0, ss = 0.0;
    int n = 0;
    FILE *f = fopen("yield.txt", "r");
    if (!f) { perror("yield.txt"); return 1; }
    while (n < 1000 && fscanf(f, "%lf", &data[n]) == 1) n++;
    fclose(f);
    for (int i = 0; i < n; i++) sum += data[i];
    double mean = sum / n;
    for (int i = 0; i < n; i++) ss += (data[i] - mean) * (data[i] - mean);
    printf("Statistics: n = %d, mean = %.3f, std = %.3f\n", n, mean, sqrt(ss / (n - 1)));
    return 0;
}
