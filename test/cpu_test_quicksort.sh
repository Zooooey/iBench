#!/bin/bash
if [ -z "$1" ]; then
    echo "Warning: ./[script].sh [cpu]"
    exit 1
fi
cpu=$1
iBench_home=/home/ccy/Develop/iBench
quick_sort="python /home/ccy/Test/cfm/benchmark.py quicksort 1.0 --cpu $cpu"

run_test(){
	threads=$1
	echo "cpu $threads pressure!"
	
	if [ "$1" -ne 0 ]; then
		exec taskset -c $cpu $iBench_home/src/cpu $threads &
		#$iBench_home/src/cpu $1 &
		cpu_pressure_pid=$!
		echo "pressure process pid:$cpu_pressure_pid"
	fi

	$quick_sort|grep "Python Wall Time:"
	#wait $!
	
	# Kill Process A
	if [ "$1" -ne 0 ]; then
		kill $cpu_pressure_pid
		echo "kill $cpu_pressure_pid"
	fi
}

run_test 0
run_test 1
run_test 2
run_test 4
run_test 8
run_test 16
run_test 32
run_test 64
run_test 128
