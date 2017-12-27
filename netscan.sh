#!/bin/bash
echo "Put range ip part 1/4, e.g.:192 255"
read r1
echo "Put range ip part 2/4, e.g: 168 255"
read r2
echo "Put range ip part 3/4, e.g.: 1 255"
read r3
echo "Put range ip part 4/4, e.g.: 10 255"
read r4
echo "Port to scan"
read port
echo "Numbers of Threads:"
read threads
echo '' > targets
for x in $(seq $r1);do for y in $(seq $r2);do for z in $(seq $r3);do for w in $(seq $r4);do
echo $port $x.$y.$z.$w >> targets
done done done done
echo "Starting Scan"
echo '' > logfile;
xargs -a targets -n 2 -P $threads sh -c 'nc $1 '$port' -v -z -w5; echo $? $1 >> logfile'
grep -w "0" logfile | cut -d " " -f2 > found.lst
echo "Found: found.lst"
