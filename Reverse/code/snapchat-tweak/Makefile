TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = snapchat-tweak


snapchat-tweak_FILES = Tweak.x
snapchat-tweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
