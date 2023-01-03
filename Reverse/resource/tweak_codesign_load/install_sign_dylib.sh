#!/bin/bash

# 首先将embedded.mobileprovision放入到和xxx.app文件同一路径
# 再将xxx-tweak.dylib、CydiaSubstrate和libsubstitute.0.dylib放入到.app/Frameworks/路径


# 主路径
my_path="/Users/venn/Desktop/TestSign/Payload/"

# 可执行文件名
executable_file_name="TestFishhook"

# tweak动态库
tweak_dylib_name="test.dylib"

# CydiaSubstrate动态库
cydiaSubstrate_name="CydiaSubstrate"

# libsubstitute.0.dylib动态库
sub_stitute0_name="libsubstitute.0.dylib"

# @executable_path
executable_path="@executable_path/"

# @loader_path
loader_path="@loader_path/"

# insert_dylib
insert_dylib_path="/usr/local/bin/insert_dylib"

# otool
otool_path="/usr/bin/otool"

# grep
grep_path="/usr/bin/grep"



# 可执行文件路径
executable_file_path=$my_path$executable_file_name".app/"
if [ -z $executable_file_path ]; then
   echo "可执行文件路径非法！！！"
   exit
fi

# Frameworks路径
frame_works_path=$executable_file_path"Frameworks/"

# 权限文件路径
embedded_file_name="embedded.mobileprovision"
embedded_file_path=$my_path$embedded_file_name
echo $embedded_file_path
# 移动embedded.mobileprovision到.app路径下
if [ ! -f "$embedded_file_path" ]; then
    echo "$embedded_file_path 不存在，请检查！！！"
    exit
fi

cp $embedded_file_path $executable_file_path


# -d 参数判断$frame_works_path是否存在，不存在则创建
if [ ! -d "$frame_works_path" ]; then
 	mkdir $frame_works_path
fi

# 拷贝动态库到Frameworks
my_dylibs=($my_path$tweak_dylib_name $my_path$cydiaSubstrate_name $my_path$sub_stitute0_name)
valid_dylib_count=0
total_dylib_count=3
for(( i=0;i<${#my_dylibs[@]};i++)) 
#${#array[@]}获取数组长度用于循环
do
    echo ${my_dylibs[i]}
    if [ ! -f "${my_dylibs[i]}" ]; then
    	echo "${my_dylibs[i]} 不存在，请检查！！！"
    	break
	fi

	cp ${my_dylibs[i]} $frame_works_path
	valid_dylib_count=`expr $valid_dylib_count + 1`

done

if [ $valid_dylib_count != $total_dylib_count ]; then 
	echo "$valid_dylib_count 个有效动态库文件，总共需要 $total_dylib_count 个动态库文件"
	exit
fi


# 移动到可执行文件路径下
cd $executable_file_path
# 检查是否已经添加成功
if [ ! -f "$otool_path" ]; then
    echo "$otool_path 不存在，请检查！！！"
    exit
fi

temp_log_name="temp.log"
$otool_path -L $executable_file_name | $grep_path $executable_path$tweak_dylib_name > $temp_log_name

# 读取本地文件的结果
temp_file_read_result=`cat $temp_log_name`
echo "$temp_file_read_result"

if [ -z "$temp_file_read_result" ]; then
   echo "二进制 $executable_file_name 文件不包含 $tweak_dylib_name 加载路径"
   # 删除临时文件
	rm -rf $temp_log_name
	if [ ! -f "$insert_dylib_path" ]; then
    	echo "$insert_dylib_path 不存在，请检查！！！"
    	exit
	fi
	# 插入操作
	$insert_dylib_path $executable_path$tweak_dylib_name $executable_file_name --all-yes --weak $executable_file_name
fi

# 对Frameworks进行操作
















