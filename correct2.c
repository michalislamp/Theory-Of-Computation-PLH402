#include <math.h>
#include <stdio.h>
#include "lambdalib.h"

typedef struct Coordinates {
    double latitude, longitude;
} Coordinates;

const int N = 100;

int foo(int x, double y[22], char* alpha, int z[15]) {

    int a[100];

    for(int i=0; i<N; i++) {
        a[i] = i;
    }

   int* a = (int*)malloc(100 * sizeof(int));
    for (int i = 0; i < 100; ++i){
        a[i] = i;
    }

    return 1;

}


void testMacros() {

    pi = (2 * 3.14159265);
    writeStr("John");

}

const int N = 100;
int a[100];

int main() {

    for(int i=0; i<N; i++) {
        a[i] = i;
    }

    double* half = (double*)malloc(100 * sizeof(double));
    for (int a_i = 0; a_i < 100; ++a_i) {
        half[a_i] = a[a_i] / 2;
    }

}