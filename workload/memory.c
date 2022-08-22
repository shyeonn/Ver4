#include <stdio.h>

#define ARR_SIZE 3

int main()
{
    int arr[ARR_SIZE];
    int i;

    //write
    for(i = 0; i<ARR_SIZE; i++){
        arr[i] = i;
    }

    //read
    for(i = 0; i<ARR_SIZE; i++){
        printf("%d\n", arr[i]);
    }


    return 0;
}