TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = gjdw-tweak

gjdw-tweak_FILES = Tweak.x
gjdw-tweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
