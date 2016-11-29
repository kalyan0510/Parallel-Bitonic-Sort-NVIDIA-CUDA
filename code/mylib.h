#include<stdio.h>

#include<omp.h>

#define pi(a) printf("%d ",a)

#define pll(a) printf("%lld ",a)

#define ps(a) printf("%s",a)

#define pln() printf("\n")

#define pia(a,n) for(int i=0;i<n;i++)pi(a[i]);pln();

#define plla(a,n) for(int i=0;i<n;i++)pll(a[i]);pln();

#define pir(a,r,c) for(int i=0;i<r;i++){for(int j=0;j<c;j++)pi(a[i][j]);pln();}

#define gi(a) scanf("%d",a)

#define gll(a) scanf("%lld",a)

#define gia(a,n) for(int i=0;i<n;i++)gi(a+i);

#define ll long long

#define min3(a,b,c) ((a>b)?((b>c)?(c):(b)):((a>c)?(c):(a)))

#define min2(a,b) ((a>b)?b:a)

#define max3(a,b,c) ((a<b)?((b<c)?(c):(b)):((a<c)?(c):(a)))

#define max2(a,b) ((a<b)?b:a)

#include <stdlib.h>     /* srand, rand */

#include <time.h>

#include<ctime>

#include<cmath>

#define pd(a) printf("%lf ",a)

#define avg2(a,b) (a+b)/2