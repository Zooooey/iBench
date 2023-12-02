#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Warning: ./[script].sh [cpu of quicksort] [cpu of l3] "
    exit 1
fi
cpu_of_test=$1
cpu_of_l3=$2
iBench_home=/home/ccy/Develop/iBench
cgroup_dir="quicksort0"
quick_sort="python /home/ccy/Test/cfm/benchmark.py quicksort 1.0 --cpu $cpu_of_test --overwrite_container False"

l3(){
    fraction=$1
	
    exec taskset -c $cpu_of_l3 $iBench_home/src/l3 $fraction &
    l3_pid=$!
    echo "l3 process pid:$l3_pid"
    mkdir /cgroup2/benchmarks/$cgroup_dir
    echo $l3_pid > /cgroup2/benchmarks/$cgroup_dir/cgroup.procs
        

	#$quick_sort|grep "Python Wall Time:"
	$quick_sort
	#wait $!
	
	# Kill Process A
	kill $l3_pid
	echo "kill $l3_pid"
}

l3  0.1
l3  0.2
l3  0.3
l3  0.4
l3  0.5
l3  0.6
l3  0.7
l3  0.8
l3  0.9
l3  1.0
