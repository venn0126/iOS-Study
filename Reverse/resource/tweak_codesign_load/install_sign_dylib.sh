#!/bin/bash
####################
#Description:
	# 将embedded.mobileprovision、xxx-tweak.dylib、CydiaSubstrate和libsubstitute.0.dylib放入到和xxx.app文件同一路径下即可
	# 配置脚本中需要自定义的参数，（TODO:需求修改这里）
	# 下载并配置第三方库`insert_dylib` 
	# 执行sh install_sign_dylib.sh即可自动完成重签名、插入动态库和修改动态库加载路径操作
	# 根据不同的提示信息进行相应的修正

#Author:augus
#Version:1.0
#CreateTime:2023-01-04 17:51:46
####################


# 主路径，TODO: 需要修改这里
my_path="/Users/augus/Documents/crackApp/jiTaxi/jude/resign/"

# 可执行文件名，TODO: 需要修改这里
executable_file_name="YYCXDriver"

# 如果$executable_file_name包含空格，比如 `SCB EASY`读取值的时候需要处理
# 读取的时候格式应该为>>> "$executable_file_name"

# tweak动态库 TODO: 需要修改这里
tweak_dylib_name="yycxdriver-tweak.dylib"

# CydiaSubstrate动态库
cydiaSubstrate_name="CydiaSubstrate"

# libsubstitute.0.dylib动态库，CydiaSubstrate所依赖的动态库，不同的越狱可能不同
# libsubstitute.dylib
lib_substitute0_name="libsubstrate.dylib"

# @executable_path
executable_path="@executable_path/"

# @loader_path
loader_path="@loader_path/"

# insert_dylib TODO: 需要修改这里
insert_dylib_path="/usr/local/bin/insert_dylib"

# old CydiaSubstrate path
old_cydia_substrate_path="/Library/Frameworks/CydiaSubstrate.framework/"

# old libsubstitute.0.dylib path
old_libsubstitute_0_dylib_path="/usr/lib/"

# PlugIns
plugIns_path="PlugIns"

# 本机的证书ID，TODO: 需要修改这里
# from `security find-identity -v -p codesigning`
# wei niu：E1BC0601C29BFF560E418E8A15436F9D43687E4B
sign_number="20C5B6B1C35556CB66043E09BE4FB3229B82A2C8"


# 可执行文件路径
executable_file_path=$my_path"$executable_file_name"".app/"
if [ -z "$executable_file_path" ]; then
   echo "可执行文件路径非法！！！"
   exit
fi

#echo "this is $executable_file_path"



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

cp $embedded_file_path "$executable_file_path"


# -d 参数判断$frame_works_path是否存在，不存在则创建
if [ ! -d "$frame_works_path" ]; then
 	mkdir $frame_works_path
fi

# 拷贝动态库到Frameworks
#my_dylibs=($my_path$tweak_dylib_name $my_path$cydiaSubstrate_name $my_path$lib_substitute0_name)
my_dylibs=($my_path$tweak_dylib_name $my_path$lib_substitute0_name)

valid_dylib_count=0
total_dylib_count=2
for(( i=0;i<${#my_dylibs[@]};i++))
#${#array[@]}获取数组长度用于循环
do
    echo ${my_dylibs[i]}
    if [ ! -f "${my_dylibs[i]}" ]; then
    	echo "${my_dylibs[i]} 不存在，请检查！！！"
    	break
	fi

	# 不覆盖已经已经存在的同名文件
	cp ${my_dylibs[i]} "$frame_works_path"
	valid_dylib_count=`expr $valid_dylib_count + 1`

done

if [ $valid_dylib_count != $total_dylib_count ]; then 
	echo "$valid_dylib_count 个有效动态库文件，总共需要 $total_dylib_count 个动态库文件"
	exit
fi


# 移动到可执行文件路径下
cd "$executable_file_path"

temp_log_name="temp.log"
# tweak动态库被依赖的加载路径
tweak_load_path=$executable_path"Frameworks/"
otool -L "$executable_file_name" | grep $tweak_load_path$tweak_dylib_name > $temp_log_name

# 读取本地文件的结果
temp_file_read_result=`cat $temp_log_name`
echo "$temp_file_read_result"
 # 删除临时文件
rm -rf $temp_log_name

if [ -z "$temp_file_read_result" ]; then
   	echo "二进制 "$executable_file_name" 文件不包含 $tweak_dylib_name"
	if [ ! -f "$insert_dylib_path" ]; then
    	echo "$insert_dylib_path 不存在，请检查！！！"
    	exit
	fi
	# 插入操作
	$insert_dylib_path $tweak_load_path$tweak_dylib_name "$executable_file_name" --all-yes --weak "$executable_file_name"
fi
# 打印加载链接
otool -L "$executable_file_name"

# 对Frameworks进行操作
cd "$frame_works_path"

# tweak xxx.dylib操作
# 对依赖的CydiaSubstrate进行加载路径修改
# install_name_tool -change /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate @loader_path/CydiaSubstrate testsigntweak.dylib
temp_log_name_0="temp0.log"
otool -L $tweak_dylib_name | grep $old_cydia_substrate_path$cydiaSubstrate_name > $temp_log_name_0
temp_file_read_result_0=`cat $temp_log_name_0`
echo "$temp_file_read_result_0"
# 删除临时文件
rm -rf $temp_log_name_0

if [ -z "$temp_file_read_result_0" ]; then
   	echo "动态库 $cydiaSubstrate_name 文件不包含被 $tweak_dylib_name 加载路径，或已经修改完成"
   	otool -L $tweak_dylib_name
else
#	install_name_tool -change $old_cydia_substrate_path$cydiaSubstrate_name $loader_path$cydiaSubstrate_name $tweak_dylib_name
    install_name_tool -change $old_cydia_substrate_path$cydiaSubstrate_name $loader_path$lib_substitute0_name $tweak_dylib_name

fi



# CydiaSubstrate操作
# 对依赖的libsubstitute.0.dylib进行加载路径修改
# install_name_tool -change /usr/lib/libsubstitute.0.dylib @loader_path/libsubstitute.0.dylib CydiaSubstrate
#temp_log_name_1="temp1.log"
#otool -L $cydiaSubstrate_name | grep $old_libsubstitute_0_dylib_path$lib_substitute0_name > $temp_log_name_1
#temp_file_read_result_1=`cat $temp_log_name_1`
#echo "$temp_file_read_result_1"
## 删除临时文件
#rm -rf $temp_log_name_1
#
#if [ -z "$temp_file_read_result_1" ]; then
#   	echo "动态库 $lib_substitute0_name 文件不包含被 $cydiaSubstrate_name 加载路径，或已经修改完成"
#   	otool -L $cydiaSubstrate_name
#else 
#	install_name_tool -change $old_libsubstitute_0_dylib_path$lib_substitute0_name $loader_path$lib_substitute0_name $cydiaSubstrate_name
#fi

# 对frameworks进行整体重签名操作
for dylib in `ls $1`
do
	# codesign -fs B1B4B69A92436CDEF7788F024CC45129537347D5 livephone-tweak.dylib
	codesign -fs $sign_number $dylib

done

# code sign /xxx.app/PlugIns/文件夹下的.appex
if [ ! -d "$executable_file_path$plugIns_path" ]; then
 	echo "$executable_file_path$plugIns_path 路径不存在，重签名动态库完成，请打包🎉🎉🎉"
 	exit
fi

# 如果存在$plugIns_path
cd "$executable_file_path$plugIns_path"
# 遍历重签名
for appex in `ls $1`
do
	codesign -fs $sign_number $appex
done

echo "重签名动态库完成，请打包🎉🎉🎉"
















