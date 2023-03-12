 #!/bin/sh

#  make.sh
#  TheosTemplate
#
#  Created by zhz on 2022/6/12.
#  


export THEOS=/opt/theos
echo $THEOS
echo $SRCROOT


# TODO: 自动读手机的ip
# TODO: 移除历史package
# TODO: 自动杀掉进程,自动重启进程

echo "1. make package..."
make clean && make && make package

# 2. make auto install; dependy `expect`
# 2.1 install expect by `brew install --build-from-source expect`
echo "2. auto install..."
if [[ ! -n $(brew list --formula | grep expect) ]] ; then
    echo "2.1 install expect..."
    brew install --build-from-source expec
fi

echo "2.2 make install..."
expect `pwd`/Bin/iphone.expect #&& make install

