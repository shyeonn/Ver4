CC=../gem5/build/X86/gem5.opt



debug :
	$(CC) se.py --cpu-type=TimingSimpleCPU -c workload/a.out