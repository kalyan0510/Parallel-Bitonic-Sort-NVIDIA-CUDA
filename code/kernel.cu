#include <stdio.h>
#include<conio.h>
#include<algorithm>
#include<stdlib.h>
#include "mylib.h"
void sortb(int* a, int size);


__global__ void bitonicSort(int* a, int n, int g, int t) {
	
	int index = blockIdx.x * blockDim.x + threadIdx.x,
		map = (index / (1 << (t - 1)))*(1 << t) + (index % (1 << (t - 1))),
		pos = (map / (1 << g)) % 2,
		m1 = (pos == 0) ? map : (map + (1 << (t - 1))),
		m2=  (pos == 0) ? (map + (1 << (t - 1))):map;
	//  m ap <>  map + 1<<(b-1)
	//printf("%d  %d    index - %d        %d , %d        %d\n", g, b, index, map, map + (1 << (b - 1)), pos);
	atomicMin(&a[m1], atomicMax(&a[m2], a[m1]));
	__syncthreads();
}


double sortb(int* a, int size,int logn2) {
	
	int* array;
	int mem = sizeof(int) * size;
	cudaMalloc((void **)&array, sizeof(int)*size);
	cudaMemcpy(array, a, sizeof(int) * size, cudaMemcpyHostToDevice);

	
	//printf("\nthreads p block = %d\n", size);
	
	int threadsPerBlock = 1024;
	int blocksPerGrid = ((size/2) + threadsPerBlock - 1) / threadsPerBlock;
	clock_t t, t1,td;
	t = clock();
	for (int g = 1; g <= logn2; g++) {
		for (int t = g; t > 0; t--) {
			//printf("g-> %d   t-> %d\n", g, t);
			bitonicSort <<<blocksPerGrid, threadsPerBlock >>>(array, size, g, t);
			//printf("\n\n");
			//
		}
	}
	td = clock();
	cudaDeviceSynchronize();
	t1 = clock();
	double time_taken = ((double)(avg2(t1,td)-t)) / CLOCKS_PER_SEC;
	//printf("\n\nfunction exec time: "); printf(" %.3lfs\n\n", time_taken,t,t1);
	//bitonicSort <<<1, (size / 2) >>>(array, size / 2);

	cudaMemcpy(a, array, size * sizeof(int), cudaMemcpyDeviceToHost);
	//size /= 2;
	//}
	cudaFree(array);
	return time_taken;
}
int * intdup(int const * src, size_t len)
{
	int * p = (int *)malloc(len * sizeof(int));
	memcpy(p, src, len * sizeof(int));
	return p;
}
void sortn(int* arr, int n) {
	int * dup = intdup(arr, n);
	clock_t t;
	t = clock();
	std::sort(dup, dup + n);
	t = clock() - t;
	double time_taken = ((double)t) / CLOCKS_PER_SEC;
	printf("exec time of Normal sort: "); printf(" %.3lfs       \nDuplicate array using sequential is sorted %s\n", time_taken, std::is_sorted(dup, dup + n) == 1 ? "YES" : "NO");
}
void wop(int * array, int sz) {
	FILE *f1;
	f1 = fopen("op.txt", "w");
	fprintf(f1, "%d ", sz);
	for (int i = 0; i<sz; i++) {

		fprintf(f1, "%d ", array[i]);
	}
	fclose(f1);

}
double avgfornP(int *arr,int n) {
	double x = 1e-9, itr=1;
	for (int i = 0; i < itr; i++) {
		x += sortb(arr, n, (int)(log(n) / log(2)));
	}
	x = x / itr;																																						
	return x;
}
double avgfornS(int *arr, int n) {
	double x = 0, itr = 1;
	for (int i = 0; i < itr; i++) {
		clock_t t;
		t = clock();
		//sortb(arr, n, (int)(log(n) / log(2)));
		std::sort(arr, arr + n);
		t = clock() - t;
		double time_taken = ((double)t) / CLOCKS_PER_SEC;
		x += time_taken;
	}
	x = x / itr;
	return x;
}
int getAnalysis(int *arr,int size,int w) {
	FILE *f1; double a, b;
	int * dup = intdup(arr,size);
	f1 = fopen("analysis.txt", "a");
	fprintf(f1, "\nAnalysis Report:    \n\n",w);
	fprintf(f1, "   N       time over        time over        is sorted?    speedup:\n");
	fprintf(f1, "   N      serial code      Bitonic CUDA code\n");
	printf( "   N       time over        time over       is sorted?    speedup:\n");
	printf( "   N      serial code      Bitonic CUDA code\n");
	for (int i = 2; i <= 20; i++) {
		memcpy(arr, dup, (1 << i) * sizeof(int));
		a = avgfornS(arr, (1 << i));
		memcpy(arr, dup, (1<<i) * sizeof(int));
		b = avgfornP(arr, (1 << i));
		
		fprintf(f1, "%7d      %.5lf          %.5lf",(1<<i), a, b);
		printf("%7d      %.5lf          %.5lf", (1 << i),a,b);
		fprintf(f1,"          %s     %f\n", std::is_sorted(arr, arr + (1 << i)) == 1 ? "YES" : "NO",a/b );
		printf("          %s     %f\n", std::is_sorted(arr, arr + (1<<i)) == 1 ? "YES" : "NO",  a/b);
		
	}
	fclose(f1);
	return 0;
}
int main(int argc, char **argv) {
	
	int* arr;

	
	int n, s;
	FILE *f = fopen("z.txt", "r");

	if (f == NULL) {
		fprintf(stderr, "File not found.\n");
		return 1;
	}

	
	fscanf(f, "%d", &n);
	printf("size n = %d log n = %d\n", n, (int)(log(n) / log(2)));

	arr = (int*)malloc(n * sizeof(int));
	for (int i = 0; i < n; i++) {
		fscanf(f, "%d", (arr + i));
		//printf(" %d ", arr[i]);
	}
	fclose(f);		
	
	for(int i=0;i<1;i++)
		getAnalysis(arr, n, 1);
	///printf("input is sorted: %s\n\n\n", std::is_sorted(arr, arr + n) == 1 ? "YES" : "NO");
	//----sortn(arr, n);
	clock_t t;
	
	//----double time_taken =sortb(arr, n, (int)(log(n) / log(2)));
	//std::sort(arr, arr + n);
	
	
	
	//---printf("\n");
	//----wop(arr,n);
	/*for (int i = 0; i < n; i++) {
		printf(" %d ", arr[i]);
	}*/
	
	//----printf("\narray using Parallel Sort is sorted: %s\n", std::is_sorted(arr, arr + n)==1?"YES":"NOOOOOOOOOOOOOOOOOOOOOOOOO");
	//-----printf("exec time: "); printf(" %lfs \n\n",time_taken); 
	puts("...");
	getch();
}