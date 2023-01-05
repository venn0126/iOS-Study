#!/bin/bash

####################
#Description:
	# 自动生成头部注释信息

#Author:augus
#Version:1.0
#CreateTime:2023-01-04 17:51:46
####################

# 如果文件名不存在
if [ ! "$1" ]
then
	echo "请输入文件名"
	exit 1
fi

# 如果文件已经存在直接用vim打开
if [ -f "$1" ]
then
	vim "$1"
	exit 2
fi

# 创建文件
touch "$1"
# 添加注释信息
echo "#!/bin/bash" >> "$1"
echo "####################" >> "$1"
echo "#Description:" >> "$1"
echo "" >> "$1"
echo "#Author:$USER" >> "$1"
echo "#Version:1.0" >> "$1"
echo "#CreateTime:`date +%F' '%H:%M:%S`" >> $1
echo "####################" >> "$1"

# 打开编辑文件
vim "$1"
