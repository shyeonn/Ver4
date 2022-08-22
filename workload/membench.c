#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/time.h>
#include <float.h>
#include <limits.h>



#ifndef STREAM_ARRAY_SIZE
#   define STREAM_ARRAY_SIZE	10000000
#endif

#ifdef NTIMES
#if NTIMES<=1
#   define NTIMES	10
#endif
#endif
#ifndef NTIMES
#   define NTIMES	10
#endif

#ifndef STREAM_TYPE
#define STREAM_TYPE double
#endif

# ifndef MIN
# define MIN(x,y) ((x)<(y)?(x):(y))
# endif
# ifndef MAX
# define MAX(x,y) ((x)>(y)?(x):(y))
# endif

static STREAM_TYPE	a[STREAM_ARRAY_SIZE], 
			b[STREAM_ARRAY_SIZE],
            c[STREAM_ARRAY_SIZE],
            d[STREAM_ARRAY_SIZE],
            e[STREAM_ARRAY_SIZE],
            f[STREAM_ARRAY_SIZE];

static double	avgtime = {0}, maxtime = {0},
		mintime = {FLT_MAX};

static char	*label = "Copy:      ";

static double	bytes = 6 * sizeof(STREAM_TYPE) * STREAM_ARRAY_SIZE;

extern double mysecond();

void print_all();

int main(){
    double  times[NTIMES];
    int k, j;
    STREAM_TYPE scalar = 3.0;

    for (j = 0; j<STREAM_ARRAY_SIZE; j++) {
	    a[j] = 1.0; 
	    b[j] = 2.0;
        c[j] = 3.0;
        d[j] = 4.0;
        e[j] = 5.0;
        f[j] = 6.0;
	}
    

#pragma optimize("", off)
    for (k=0; k<NTIMES; k++)
	{
        times[k] = mysecond();
        //printf("time1 : %f\n", mysecond());
        memcpy(b,a,STREAM_ARRAY_SIZE*sizeof(STREAM_TYPE));
        //printf("time2 : %f\n", mysecond());
        memcpy(c,b,STREAM_ARRAY_SIZE*sizeof(STREAM_TYPE));
        //printf("time3 : %f\n", mysecond());
        memcpy(d,c,STREAM_ARRAY_SIZE*sizeof(STREAM_TYPE));
        //printf("time4 : %f\n", mysecond());


        times[k] = mysecond() - times[k];
    }
#pragma optimize("", on)

    for (k=1; k<NTIMES; k++) /* note -- skip first iteration */
	{

	    avgtime = avgtime + times[k];
	    mintime = MIN(mintime, times[k]);
	    maxtime = MAX(maxtime, times[k]);
	    
	}

    printf("Function    Best Rate GB/s  Avg time     Min time     Max time\n");
		avgtime = avgtime/(double)(NTIMES-1);

		printf("%s%12.1f  %11.6f  %11.6f  %11.6f\n", label,
	       1.0E-09 * bytes/mintime,
	       avgtime,
	       mintime,
	       maxtime);




    return 0;
}


#include <sys/time.h>

double mysecond()
{
        struct timeval tp;
        struct timezone tzp;
        int i;

        i = gettimeofday(&tp,&tzp);
        return ( (double) tp.tv_sec + (double) tp.tv_usec * 1.e-6 );
}

void print_all(STREAM_TYPE *array)
{
    for(int i = 0; i < STREAM_ARRAY_SIZE; i++)
    {
        printf("%f ", array[i]);
    }
    printf("\n");
}