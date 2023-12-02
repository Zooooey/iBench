#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Warning: ./[script].sh [cpu of quicksort] [cpu of memBw] "
    exit 1
fi
cpu_of_test=$1
cpu_of_memBw=$2
iBench_home=/home/ccy/Develop/iBench
cgroup_dir="quicksort0"
quick_sort="python /home/ccy/Test/cfm/benchmark.py quicksort 1.0 --cpu $cpu_of_test --overwrite_container False"

memBw(){
    threads=$1
	echo "memBw threads :$threads"
	
	if [ "$1" -ne 0 ]; then
		# cpu of memBw not same as quicksort, since we want only memory interference.
		exec taskset -c $cpu_of_memBw $iBench_home/src/memBw $threads &
		memBw_pid=$!
		echo "pressure process pid:$memBw_pid"
        mkdir /cgroup2/benchmarks/$cgroup_dir
        echo $memBw_pid > /cgroup2/benchmarks/$cgroup_dir/cgroup.procs
        
	fi

	#$quick_sort|grep "Python Wall Time:"
	$quick_sort
	#wait $!
	
	# Kill Process A
	if [ "$1" -ne 0 ]; then
		kill $memBw_pid
		echo "kill $memBw_pid"
	fi
}

memBw  0
memBw  1
memBw  2
memBw  4
memBw  8
memBw  16
memBw  32
