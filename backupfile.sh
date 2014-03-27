#!/bin/bash
#shell编程完成文件备份。备份用户指定的文件，将文件备份到目录文件名_backup中（若目录不存在则自动建立），备份文件的文件名格式为文件名_bak_年月日_时分秒。

backpath="${HOME}/_backup"
if [ ! -d "$backpath" ] 
then
    echo "备份目录不存在，自动创建"
    mkdir $backpath
fi

for file in $@
do
    if [ -f "$file" ]
    then
        filename=$(basename "$file")
        backupname="${filename}_bak_$(date +%y%m%d)_$(date +%k%M%S)"
        fullpath="${backpath}/${backupname}"
      	cp -f "$file" "$fullpath"
        echo "$file 文件备份到 $fullpath"
    else
        echo "$file 不是一个有效的文件"
    fi    
done
