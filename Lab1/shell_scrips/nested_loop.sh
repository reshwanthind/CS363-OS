#!/bin/sh

for ind in 0 1 2 3 4 5 6 7 8 9 
do
	VAR=$ind
	while [ "$VAR" -ge 0 ] 
	do
		echo -n "$VAR "
		VAR=$(expr $VAR - 1)

	done
	echo
done
