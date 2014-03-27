#!/bin/bash
#编写shell脚本用循环求1-100的和

sum=0
for i in $(seq 1 100)
do
    sum=$(($sum+$i))
done
echo $sum

