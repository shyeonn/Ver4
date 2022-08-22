all:
	@echo  "1M cpy_1M 10M cpy_10M memben1M memben10M memben100M membenmini"


1M: 
	gcc -O -DSTREAM_ARRAY_SIZE=1000000 stream.c -o stream.1M
	./stream.1M

cpy_1M: 
	gcc -O -DSTREAM_ARRAY_SIZE=1000000 stream_strcpy.c -o stream_strcpy.1M
	./stream_strcpy.1M

10M: 
	gcc -O -DSTREAM_ARRAY_SIZE=10000000 stream.c -o stream.10M
	./stream.10M

cpy_10M: 
	gcc -O -DSTREAM_ARRAY_SIZE=10000000 stream_strcpy.c -o stream_strcpy.10M
	./stream_strcpy.10M


cpy_100M: 
	gcc -O -DSTREAM_ARRAY_SIZE=100000000 stream_strcpy.c -o stream_strcpy.100M
	./stream_strcpy.10M

memben0.5M:
	gcc -O -DSTREAM_ARRAY_SIZE=500000 membench.c -o membench.0.5M
	./membench.0.5M

memben1M:
	gcc -O -DSTREAM_ARRAY_SIZE=1000000 membench.c -o membench.1M
	./membench.1M

memben10M:
	gcc -O -DSTREAM_ARRAY_SIZE=10000000 membench.c -o membench.10M
	./membench.10M

memben100M:
	gcc -O -DSTREAM_ARRAY_SIZE=100000000 membench.c -o membench.100M
	./membench.100M

membenmini:
	gcc -O -DSTREAM_ARRAY_SIZE=100 membench.c -o membench.mini
	./membench.mini
	
stream1M:
	gcc -O -DSTREAM_ARRAY_SIZE=1000000 stream.c -o stream.1M
	./stream.1M


openMP:
	gcc -O -fopenmp -DSTREAM_ARRAY_SIZE=1000000 stream_strcpy.c -o stream_strcpy_MP.1M
	./stream_strcpy_MP.1M


openMP_10M:
	gcc -O -fopenmp -DSTREAM_ARRAY_SIZE=10000000 stream_strcpy.c -o stream_strcpy_MP.10M
	./stream_strcpy_MP.10M