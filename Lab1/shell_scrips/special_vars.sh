#!/bin/sh
echo " File name : $0 "
echo " First parameter : $1 "
echo " Third parameter : $3 "
echo " Quoted Values (\ $@ ) : $@ "
echo " Quoted Values (\$*) : $* "
echo " Number of Parameters : $# "
echo " Exit status of last command : $? "
echo " Process ID ( PID ) of script : $$"
current_date=$(date)
echo " Current Date and Time using \$(date) : $current_date "
