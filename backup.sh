#!/bin/bash
#一台装有Linux操作系统的计算机。
#源数据：在主硬盘/home/hbzy/下建立workdata存放用户工作数据文件
#备份位置：
#主硬盘/home/hbzy/下建立备份目录disk1backup
#另一块硬盘挂载为/dev/disk2backup
#备份操作要求：每天将源数据备份到两个位置，保留最近三次的备份文件，命名要求为worknewdata.tar、work2nddata.tar、work3rddata.tar。

backdisk1=$HOME/disk1backup
backdisk2=/dev/disk2backup
workspace=$HOME/workdata
backtmpfile=/tmp/tmpworkdatafile.tar
firstfile=worknewdata.tar
secondfile=work2nddata.tar
thridfile=work3rddata.tar

echo "===========目录检查============"
if [ ! -d $backdisk1 ]
then
    echo "创建目录 $backdisk1"
    mkdir $backdisk1
fi
if [ ! -w $backdisk1 ]
then
    echo "对备份目录 $backdisk1 没有写权限，请检查"
fi

if [ ! -d $backdisk2 ]
then
    echo "授权创建目录 $backdisk2"
    sudo mkdir $backdisk2
fi
if [ ! -w $backdisk2 ]
then
    echo "对备份目录 $backdisk2 没有写权限，请检查"
fi

if [ ! -d $workspace ]
then
    echo "建立工作目录 $workspace"
    mkdir $workspace
fi

echo "===========开始备份============"
cd $workspace
filelist=$( ls -A )
if [ "$filelist" == "" ]
then
    echo "工作目录为空，备份终止。"
    exit 1
fi
echo "===========打包文件============"
tar -cvf $backtmpfile $filelist
echo "===========打包完成============"
echo "=======复制到备份文件夹========"
if [ -f $backdisk1/$thridfile ]
then
    rm -f $backdisk1/$thridfile
fi
if [ -f $backdisk2/$thridfile ]
then
    rm -f $backdisk2/$thridfile
fi

if [ -f $backdisk1/$secondfile ]
then
    mv $backdisk1/$secondfile $backdisk1/$thridfile
fi
if [ -f $backdisk2/$secondfile ]
then
    mv $backdisk2/$secondfile $backdisk2/$thridfile
fi

if [ -f $backdisk1/$firstfile ]
then
    mv $backdisk1/$firstfile $backdisk1/$secondfile
fi
if [ -f $backdisk2/$firstfile ]
then
    mv $backdisk2/$firstfile $backdisk2/$secondfile
fi

cp $backtmpfile $backdisk1/$firstfile
cp $backtmpfile $backdisk2/$firstfile

rm -f $backtmpfile

echo "===========备份完成============"
exit 0
