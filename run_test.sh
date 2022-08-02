#!/bin/sh
##../gem5/build/X86/gem5.opt se.py -n 1 --sys-voltage 1V --cmd ./workload/stream.1M
#1 cpu 1개, 
#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 --sys-voltage 1V --cmd ../gem5/tests/test-progs/hello/bin/x86/linux/hello32 --output result

#../gem5/build/X86/gem5.opt --outdir=./test1 se.py -n 1 - --sys-voltage 1V --cmd ./workload/stream.1M --output result


#for CPU_var in 1 2 4  #코어수 변경 
#do
#    for MEM_var in DDR4_2400_16x4 HBM_2000_4H_1x64 GDDR5_4000_2x32  #메모리 종류 변경(default : 512MB) 
#    do
        
#        echo "CPU Num : $CPU_var | Memory : $MEM_var "
#        ../gem5/build/X86/gem5.opt --outdir=./test1/${MEM_var}_CPU$CPU_var se.py -n $CPU_var --sys-clock '3GHz' --mem-type $MEM_var --cpu-type X86TimingSimpleCPU --cmd ./workload/stream.1M
        
#    done
    
#done


../gem5/build/X86/gem5.opt --outdir=./test1/test se.py \
--cpu-type DerivO3CPU -n 16 --cpu-clock 3GHz \
--mem-type HBM_2000_4H_1x64 --mem-channels 2 \
--caches --l2cache \
--cmd ./workload/stream_omp.1M_1T \
>> ./test1/test/result2.txt


../gem5/build/X86/gem5.opt --outdir=./test1/test se.py \
--cpu-type DerivO3CPU -n 16 --cpu-clock 3GHz \
--mem-type GDDR5_4000_2x32 --mem-channels 2 \
--caches --l2cache \
--cmd ./workload/stream_omp.1M_1T \
>> ./test1/test/result2.txt


#--cmd ../gem5/tests/test-progs/hello/bin/x86/linux/hello32 