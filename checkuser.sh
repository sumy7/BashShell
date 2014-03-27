#!/bin/bash
#写一个脚本文件checkuser，该脚本运行时带用户名作为参数，在/etc/passwd文件中查找用户，如有，则输出“<user> in the /etc/passwd”;否则输出” no such user on our system”

if [ ! $# -eq 1 ]
then
    echo "Invalid number of parameters!"
    exit 1
fi

username=$1
check=$( grep "^${username}:" /etc/passwd)
if [ ! check == "" ]
then
    echo "$username in the /etc/passwd"
else
    echo "no such user on our system"
fi

exit 0
