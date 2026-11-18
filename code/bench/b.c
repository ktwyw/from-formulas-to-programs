#include <stdio.h>
#include <math.h>
#include <time.h>
int main(void){ long n=10000000; double h=M_PI/n, s=0.0; struct timespec a,b;
 clock_gettime(CLOCK_MONOTONIC,&a);
 for(long i=1;i<n;i++) s+=sin(i*h);
 s=h*(s+0.5*(sin(0.0)+sin(M_PI)));
 clock_gettime(CLOCK_MONOTONIC,&b);
 printf("%.4f %.12f\n",(b.tv_sec-a.tv_sec)+1e-9*(b.tv_nsec-a.tv_nsec),s);}
