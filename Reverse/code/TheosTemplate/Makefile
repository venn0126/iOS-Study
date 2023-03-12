DEBUG = 1
#用于调试的设备地址
THEOS_DEVICE_IP = 192.168.0.101
#THEOS_DEVICE_PORT = 2222
ARCHS = arm64e #armv7 arm64

#用于编译的SDK和支持的ios最低版本
#TARGET = iphone:11.2:10.0

include $(THEOS)/makefiles/common.mk

# 工程名称
TWEAK_NAME = theostemplate
# 进程名称
INSTALL_TARGET_PROCESSES = xitu

# 采用ARC内存管理
theostemplate_CFLAGS = -fobjc-arc

# 头文件
theostemplate_OBJCFLAGS += -I./TheosTemplate/*/
theostemplate_OBJCFLAGS += -I./TheosTemplate/Headers/
theostemplate_OBJCFLAGS += -I./TheosTemplate/Classes/
#theostemplate_OBJCFLAGS += -I./TheosTemplate/Classes/*/*.h

# 编译的实现文件
theostemplate_FILES = Tweak.xi
theostemplate_FILES += $(wildcard TheosTemplate/Classes/*.mm) $(wildcard TheosTemplate/Classes/*/*.mm)
theostemplate_FILES += $(wildcard TheosTemplate/Classes/*.m) $(wildcard TheosTemplate/Classes/*/*.m)


# 导入系统的frameworks
theostemplate_FRAMEWORKS = Foundation UIKit

# 导入系统库
theostemplate_LIBRARIES = stdc++ c++

# 导入第三方Frameworks, 动态库需特殊处理
#theostemplate_LDFLAGS += -F./Libraries/dynamic -F./Libraries/static   # 识别的库实现
#theostemplate_CFLAGS  += -F./Libraries/dynamic -F./Libraries/static   # 头文件识别
#theostemplate_FRAMEWORKS += WCBFWStatic WCBFWDynamic
# 导入第三方lib
#theostemplate_LDFLAGS += -L./Libraries/dynamic -L./Libraries/static 	# 识别的库实现
#theostemplate_CFLAGS  += -I./Libraries/include  						# 头文件识别
#theostemplate_LIBRARIES += WCBStatic WCBDyLib

#忽略OC警告，避免警告导致编译不过
theostemplate_OBJCFLAGS +=  -Wno-deprecated-declarations -Wno-unused-variable


include $(THEOS_MAKE_PATH)/tweak.mk


#before-package::
#	sh bin/check_dynamic_lib.sh  #动态库处理脚本
#	cp ./bin/postinst .theos/_/DEBIAN/
#	cp ./bin/postrm .theos/_/DEBIAN/
#	chmod 755 .theos/_/DEBIAN/postinst
#	chmod 755 .theos/_/DEBIAN/postrm
after-install::
	install.exec "killall -9 __Process__"
p::
	make package
c::
	make clean
i::
	make
	make p
	make install

