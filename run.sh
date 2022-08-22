#!/bin/sh
##../gem5/build/X86/gem5.opt se.py -n 1 --sys-voltage 1V --cmd ./workload/stream.1M
#1 cpu 1개, 
#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 --sys-voltage 1V --cmd ../gem5/tests/test-progs/hello/bin/x86/linux/hello32 --output result

#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 - --sys-voltage 1V --cmd ./workload/stream.1M --output result

testnum=12
isa="X86"
if [ -d "./result/HBM_compare/test$testnum" ]; then
    rm -r ./result/HBM_compare/test$testnum
fi
mkdir ./result/HBM_compare/test$testnum

echo \
"[version log]
1 : TimingsimpleCPU/1_core/4GHz_clock/nocache/no_openMP
2 : workload -> memmove 
3 : for loop unroll
4 : add L1 cache 
5 : add L2 cache
6 : OOO single
7 : dual, openMP 
8 : core= 4
9 : core= 8 
10 : L2 delete [+] 
11 : delete memcpy [+] 
12 : core = 16 

 " \
> ./result/HBM_compare/test$testnum/log.txt 

MEM_var=HBM_2000_4H_1x64

for MEM_chan in 1 2 4 8 16  #메모리 종류 변경(default : 512MB) 
do
../gem5/build/$isa/gem5.opt \
--outdir=./result/HBM_compare/test$testnum/${MEM_chan}channel se.py \
--cpu-type X86O3CPU --cpu-clock 4GHz --num-cpus 16 \
--mem-type $MEM_var --mem-channels $MEM_chan \
--caches \
--cmd ./workload/stream_strcpy_MP_2.1M \
>> ./result/HBM_compare/test$testnum/${MEM_chan}channel.txt &
done


#--debug-flags=O3PipeView --debug-start=0 --debug-file=trace.out \



#../gem5/build/X86/gem5.opt --outdir=./test1/test se.py -n 1 --mem-type GDDR5_4000_2x32 --sys-clock '3GHz' --cpu-type X86TimingSimpleCPU --cmd ./workload/stream.1M 
#../gem5/build/ARM/gem5.opt --outdir=./Helloworld se.py --cmd ../gem5/tests/test-progs/hello/bin/arm/linux/hello
#../gem5/build/RISCV/gem5.opt --outdir=./Helloworld se.py --cmd ../gem5/tests/test-progs/hello/bin/riscv/linux/hello