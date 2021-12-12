#!/bin/sh

TEMPERATURE=$(sensors | grep "Package id 0:" | tr -d '+' | awk '{print $4}')

echo " $(grep 'cpu ' /proc/stat | awk '{cpu_usage=($2+$4)*100/($2+$4+$5)}
END {printf "%0.2f%%", cpu_usage}')  $(sensors | grep temp1 | head -1 | awk '{print $2}')"
