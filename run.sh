#!/bin/sh
##../gem5/build/X86/gem5.opt se.py -n 1 --sys-voltage 1V --cmd ./workload/stream.1M
#1 cpu 1개, 
#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 --sys-voltage 1V --cmd ../gem5/tests/test-progs/hello/bin/x86/linux/hello32 --output result

#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 - --sys-voltage 1V --cmd ./workload/stream.1M --output result

testnum=4
mkdir ./result/test$testnum

echo \
"[version log]
3 : default
4 : nmem-channels : 4->2" \
> ./result/test$testnum/Change.txt 

for MEM_var in DDR4_2400_16x4 HBM_2000_4H_1x64 GDDR5_4000_2x32  #메모리 종류 변경(default : 512MB) 
do
../gem5/build/X86/gem5.opt --outdir=./result/test$testnum/$MEM_var se.py \
--cpu-type DerivO3CPU -n 8 --cpu-clock 3GHz \
--mem-type $MEM_var --mem-channels 2 \
--caches --l2cache \
--cmd ./workload/stream_omp.1M_1T \
>> ./result/test$testnum/result_$MEM_var.txt &
done
    


#../gem5/build/X86/gem5.opt --outdir=./test1/test se.py -n 1 --mem-type GDDR5_4000_2x32 --sys-clock '3GHz' --cpu-type X86TimingSimpleCPU --cmd ./workload/stream.1M 
