# Config
ARCH = arm64
IOS_VERSION = 10.0
EXECUTABLE_NAME = GTAppTools

# Dirs
RELEASE_DIR = Release
PROJECT_DIR = GTiTools
EXECUTABLE_FILE = $(RELEASE_DIR)/$(EXECUTABLE_NAME)

# Header Files
HEADER_DIR1 = $(PROJECT_DIR)
HEADER_DIR2 = $(PROJECT_DIR)/SystemHeader
HEADER_DIR3 = $(PROJECT_DIR)/Extension
HEADER_DIR4 = $(PROJECT_DIR)/Model
HEADER_DIR5 = $(PROJECT_DIR)/Tool

# Source Files
SOURCE_FILES = $(HEADER_DIR1)/*.m
SOURCE_FILES += $(HEADER_DIR3)/*.m
SOURCE_FILES += $(HEADER_DIR4)/*.m
SOURCE_FILES += $(HEADER_DIR5)/*.m

# Entitlements
ENTITLEMENT_FILE = $(RELEASE_DIR)/GTiTools.entitlements

codesign: compile
	@codesign -fs- --entitlements $(ENTITLEMENT_FILE) $(EXECUTABLE_FILE)

compile:
	@xcrun -sdk iphoneos \
		clang -arch $(ARCH) \
		-mios-version-min=$(IOS_VERSION) \
		-fobjc-arc \
		-framework Foundation \
		-framework UIKit \
		-framework MobileCoreServices \
		-Os \
		-I $(HEADER_DIR1) \
		-I $(HEADER_DIR2) \
		-I $(HEADER_DIR3) \
		-I $(HEADER_DIR4) \
		-I $(HEADER_DIR5) \
		$(SOURCE_FILES) \
		-o $(EXECUTABLE_FILE)
