#include<iostream>
#include "mylib.h"
#include <fstream>
using namespace std;
void populateFile(int count)
{
	
	FILE *f1;
	f1 = fopen("z.txt", "w");
    if (f1==NULL )
    {
       printf("ERROR\n");  	
       return;
    }
	fprintf(f1,"%d\n", count);
    for(int index=0; index<count; index++)
    {
        
        fprintf(f1,"%d ", (rand()%1000)+1);
    }
    fclose(f1);
    printf("completed\n");
}
int main(){
	
	srand( time( NULL ) );
	populateFile(1<<20);
}
