#!/bin/bash
if [ "$#" -ne 2 ]; then
    echo "Warning: ./[script].sh [cpu of quicksort] [cpu of l2] "
    exit 1
fi
cpu_of_test=$1
cpu_of_l2=$2
iBench_home=/home/ccy/Develop/iBench
cgroup_dir="quicksort0"
quick_sort="python /home/ccy/Test/cfm/benchmark.py quicksort 1.0 --cpu $cpu_of_test --overwrite_container False"

l2(){
    fraction=$1
	
    exec taskset -c $cpu_of_l2 $iBench_home/src/l2 $fraction &
    l2_pid=$!
    echo "l2 process pid:$l2_pid"
    mkdir /cgroup2/benchmarks/$cgroup_dir
    echo $l2_pid > /cgroup2/benchmarks/$cgroup_dir/cgroup.procs
        

	#$quick_sort|grep "Python Wall Time:"
	$quick_sort
	#wait $!
	
	# Kill Process A
	kill $l2_pid
	echo "kill $l2_pid"
}

l2  0.1
l2  0.2
l2  0.3
l2  0.4
l2  0.5
l2  0.6
l2  0.7
l2  0.8
l2  0.9
l2  1.0
