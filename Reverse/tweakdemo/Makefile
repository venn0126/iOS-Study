TARGET := iphone:clang:latest:10.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TweakDemo

TweakDemo_FILES = Tweak.x
TweakDemo_CFLAGS = -fobjc-arc
TweakDemo_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
