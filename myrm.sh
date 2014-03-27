#!/bin/bash
#删除指定文件夹中的所有文件，若之后为空，则删除上层目录。

origal=$(pwd)
if [ -d $1 ]
then
    cd "$1"
    echo "将要删除 $(pwd) 下的所有文件，及空目录 $(pwd) "
    read -p "确定（y/n）：" answer
    if [ "$answer" == "y" ]
    then
        rm -fv *
        rm -fv .*
        lsfile=$(ls -A)
        if [ "$lsfile" == "" ]
        then
            echo "目录为空，删除。"
            cd "$origal"
            rmdir -v "$1"
        else
            echo "目录不为空。"
        fi
    fi
else
    echo "无效的目录参数。"
fi

