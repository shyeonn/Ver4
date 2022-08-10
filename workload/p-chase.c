#include <stdio.h>

#ifndef STRIDE
#   define STRIDE   2048
#endif

#ifndef NUMBER
#   define NUMBER   100
#endif

#ifndef SIZE
#   define SIZE     
#endif

main(){
    for(i=0; i<SIZE; i++){
        array[i] = (i+STRIDE) % SIZE;
    }
}