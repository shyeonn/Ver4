#!/bin/sh
##../gem5/build/X86/gem5.opt se.py -n 1 --sys-voltage 1V --cmd ./workload/stream.1M
#1 cpu 1개, 
#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 --sys-voltage 1V --cmd ../gem5/tests/test-progs/hello/bin/x86/linux/hello32 --output result

#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 - --sys-voltage 1V --cmd ./workload/stream.1M --output result

testnum=11
isa="X86"
if [ -d "./result/test$testnum" ]; then
    rm -r ./result/test$testnum
fi
mkdir ./result/test$testnum

echo \
"[version log]
3 : default
--cpu-type DerivO3CPU -n 8 --cpu-clock 3GHz --mem-type DDR4_2400_16x4 --mem-channels 4 --caches --l2cache --cmd ./workload/stream_omp.1M_1T
4 : mem-channels 4->2
5 : cpu-clock 3GHz -> 4GHz | mem-channels 2->4 
6 : workload 1M -> 10M | mem-size 512MB -> 2GB | mem-channels 2->8 | except DDR4
7 : ISA : ARM | goback default
6-1 : cpu core = 16 -2 : memchannels 1 -3 : mem-channels 2
9 : Memchannel = 1, nocache
10: " \
> ./result/test$testnum/Change.txt 
    
for MEM_var in HBM_2000_4H_1x64 GDDR5_4000_2x32 DDR4_2400_16x4   #메모리 종류 변경(default : 512MB) 
do
../gem5/build/$isa/gem5.opt \
--outdir=./result/test$testnum/$MEM_var se.py \
--cpu-type DerivO3CPU -n 8 --cpu-clock 4GHz \
--caches --l2cache \
--mem-type $MEM_var  \
--cmd ./workload/stream_omp_$isa.1M \
>> ./result/test$testnum/result_$MEM_var.txt &
done


#--debug-flags=O3PipeView --debug-start=0 --debug-file=trace.out \



#../gem5/build/X86/gem5.opt --outdir=./test1/test se.py -n 1 --mem-type GDDR5_4000_2x32 --sys-clock '3GHz' --cpu-type X86TimingSimpleCPU --cmd ./workload/stream.1M 
#../gem5/build/ARM/gem5.opt --outdir=./Helloworld se.py --cmd ../gem5/tests/test-progs/hello/bin/arm/linux/hello
#../gem5/build/RISCV/gem5.opt --outdir=./Helloworld se.py --cmd ../gem5/tests/test-progs/hello/bin/riscv/linux/hello