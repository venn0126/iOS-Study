#!/bin/bash
# 使用方法：
# * 首先输入更新后的token：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
# * 然后输入需要更新的.git/config的绝对地址：/Users/augus/Documents/Sohu-Doc/.git/config
# * 完成🎉
read -p '请输入更新后的token: ' input_token
echo $input_token

if [ -z $input_token ]; then
   echo "输入token非法，请重新输入"
   exit
fi 

read -p '请输入要更新的文件: ' input_file
if [ -z $input_file ]; then
   echo "输入更新文件非法，请重新输入"
   exit
fi
echo $input_file

# 更新github的开发者token，需要传入字符串格式为https://${token}@
# 格式化字符串
head="https://"
token=$input_token
tail=@
last_str=$head$token$tail
echo $last_str

# 开始替换字符串
sed -i '' "s|https.*@|${last_str}|g" $input_file
echo '更新完成🎉🎉🎉'
