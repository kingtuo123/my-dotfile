#!/bin/bash

file_energy_uj="/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj"
file_max_energy_range_uj="/sys/class/powercap/intel-rapl/intel-rapl:0/max_energy_range_uj"

energy_max=$(<$file_max_energy_range_uj)
energy_old=$(<$file_energy_uj)


while true; do
	sleep 1
	energy_now=$(<$file_energy_uj)
	if [[ $energy_now -ge $energy_old ]]; then
		watt=$(( (energy_now - energy_old) / 100000 ))
	else
		watt=$(( (energy_max - energy_old + energy_now) / 100000 ))
	fi
	energy_old=$energy_now
	watt="$((watt/10)).$((watt%10))"
	printf "   功耗 %5sw   \n" $watt
done
