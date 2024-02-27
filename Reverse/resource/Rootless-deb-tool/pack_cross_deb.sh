#!/bin/bash
echo "
  A cross-platform deb packaging tool includes rootless deb
#     #                                          #     # #     #
##   ## #    #  ####  #####   ##   #    #  ####   #   #  ##   ##
# # # # #    # #        #    #  #  ##   # #    #   # #   # # # #
#  #  # #    #  ####    #   #    # # #  # #         #    #  #  #
#     # #    #      #   #   ###### #  # # #  ###    #    #     #
#     # #    # #    #   #   #    # #   ## #    #    #    #     #
#     #  ####   ####    #   #    # #    #  ####     #    #     #
"
set -e

DEB_BASE_NAME="BLBYExtension"
DEB_AUTHOR="Augus"
DEB_DES="Be a hero"
DEB_ARCHITECTURE="iphoneos-arm" ### you don`t need config this value, cause its auto change to arm64 in rootless
TARGET_PROCESS="BLBY"
TARGET_BUNDLE=("com.gt.byblios")

echo "Enter the version of the DEB package (e.g., 1.0.0)
Version:"
read DEB_VERSION

if [[ ! "$DEB_VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Invalid format for version number. It should be like '1.0.0'"
  exit 1
fi

DEB_NAME="${DEB_BASE_NAME}-${DEB_VERSION}"

SAFE_GUARD(){
    local exit_code=$?
    if [ $exit_code -ne 0 ]
    then
        echo "❌: $1"
        exit $exit_code
    else
		if [ "$2" ] 
    	then
        echo "🍻: $2"
    	fi
    fi
}

### Dependencies Check
COMMANDS=("dpkg-deb" "file" "otool" "install_name_tool")
for CMD in ${COMMANDS[@]}; do
  if ! command -v $CMD &>/dev/null; then
    SAFE_GUARD "$CMD could not be found" "Environmental legality"
  fi
done

cd "$(dirname "$0")"
SAFE_GUARD "Failed to change directory to $(dirname "$0")"
for dylib in *.dylib
do
    if [ -f "$dylib" ]; then
        echo "Processing $dylib"

        mkdir -p debpack/DEBIAN
        mkdir -p debpack/Library/MobileSubstrate/DynamicLibraries
        cp "$dylib" debpack/Library/MobileSubstrate/DynamicLibraries/
        SAFE_GUARD "Failed to copy $dylib to debpack/Library/MobileSubstrate/DynamicLibraries/"

        cat <<EOF > debpack/Library/MobileSubstrate/DynamicLibraries/$(basename $dylib .dylib).plist
{
    Filter = {
        Executables = (
            $TARGET_PROCESS
        );
        Bundles = (
            "${TARGET_BUNDLE[0]}",
            "${TARGET_BUNDLE[1]}"
        );
    };
}

EOF
    SAFE_GUARD "Failed to create plist file for $dylib"

        cat <<EOF > debpack/DEBIAN/control
Package: ${DEB_BASE_NAME}
Version: ${DEB_VERSION}
Section: custom
Priority: optional
Architecture: ${DEB_ARCHITECTURE}
Replaces: ${DEB_BASE_NAME}
Provides: ${DEB_BASE_NAME}
Conflicts: ${DEB_BASE_NAME}
Essential: no
Maintainer: ${DEB_AUTHOR} <MustangYM@yeah.net>
Depends: mobilesubstrate
Description: ${DEB_DES}
Name: ${DEB_NAME}
Author: ${DEB_AUTHOR}
EOF
        SAFE_GUARD "Failed to create control file for $dylib"
        
        dpkg-deb -b debpack ${DEB_NAME}-${DEB_ARCHITECTURE}.deb
        SAFE_GUARD "Failed to create deb package for $dylib"

        rm -rf debpack
        SAFE_GUARD "Failed to remove debpack"

        ### End of create Deb

        ### Start rootless
        OS=`uname -s`
        ARCH=`uname -m`
        
        case "$OS" in
          Linux*)
            OS_TYPE="linux"
            ;;
          Darwin*)
            OS_TYPE="macosx"
            ;;
          *)
            SAFE_GUARD "Unsupported OS"
            exit
            ;;
        esac

        case "$ARCH" in
          x86_64)
            ARCH_TYPE="x86_64"
            ;;
          aarch64|arm64)
            if [ "$OS_TYPE" == "macosx" ]; then
                ARCH_TYPE="arm64"
            else
                ARCH_TYPE="aarch64"
            fi
            ;;
          *)
            SAFE_GUARD "Unsupported architecture"
            exit
            ;;
        esac

        LDID="./ldid_${OS_TYPE}_${ARCH_TYPE} -Hsha256"
        chmod +x ldid_${OS_TYPE}_${ARCH_TYPE}
        SAFE_GUARD "Failed to change permissions for ldid_${OS_TYPE}_${ARCH_TYPE}" "Change permissions for ldid_${OS_TYPE}_${ARCH_TYPE}"

        DEB_FILE="${DEB_NAME}-${DEB_ARCHITECTURE}.deb"
        echo "创建的DEB文件名称: $DEB_FILE"
        TEMPDIR_OLD="$(mktemp -d)"
        TEMPDIR_NEW="$(mktemp -d)"

        if [[ ! -f $DEB_FILE ]]; then
          echo "文件$DEB_FILE不存在"
          exit 1
        fi
        dpkg-deb -R "$DEB_FILE" "$TEMPDIR_OLD"
        SAFE_GUARD "Failed to extract $DEB_FILE to $TEMPDIR_OLD"

        chmod 755 $TEMPDIR_OLD/DEBIAN/*
        SAFE_GUARD "Failed to change permissions for $TEMPDIR_OLD/DEBIAN/*" "Change permissions for $TEMPDIR_OLD/DEBIAN/*"

        chmod 644 $TEMPDIR_OLD/DEBIAN/control
        SAFE_GUARD "Failed to change permissions for $TEMPDIR_OLD/DEBIAN/control" "Change permissions for $TEMPDIR_OLD/DEBIAN/control"

        mkdir -p "$TEMPDIR_NEW"/var/jb
        cp -a "$TEMPDIR_OLD"/DEBIAN "$TEMPDIR_NEW"
        # Modify control to arm64
        sed 's|iphoneos-arm|iphoneos-arm64|' < "$TEMPDIR_OLD"/DEBIAN/control > "$TEMPDIR_NEW"/DEBIAN/control.temp
        SAFE_GUARD "Failed to replace iphoneos-arm with iphoneos-arm64 in $TEMPDIR_OLD/DEBIAN/control" "Replaced iphoneos-arm with iphoneos-arm64"

        # Modify control Name to xxx-Rootless
        sed 's|^\(Name: .*\)$|\1-Rootless|' "$TEMPDIR_NEW"/DEBIAN/control.temp > "$TEMPDIR_NEW"/DEBIAN/control
        rm "$TEMPDIR_NEW"/DEBIAN/control.temp
        SAFE_GUARD "Failed to append -Rootless to Name in $TEMPDIR_NEW/DEBIAN/control" "Appended -Rootless to Name"


        rm -rf "$TEMPDIR_OLD"/DEBIAN
        mv -f "$TEMPDIR_OLD"/.* "$TEMPDIR_OLD"/* "$TEMPDIR_NEW"/var/jb >/dev/null 2>&1 || true

        if [ -d "$TEMPDIR_NEW/var/jb/Library/MobileSubstrate/DynamicLibraries" ]; then
            mkdir -p "$TEMPDIR_NEW/var/jb/usr/lib"
            mv "$TEMPDIR_NEW/var/jb/Library/MobileSubstrate/DynamicLibraries" "$TEMPDIR_NEW/var/jb/usr/lib/TweakInject"
        fi

        find "$TEMPDIR_NEW" -type f | while read -r file; do
            if file -b "$file" | grep -q "Mach-O"; then
                INSTALL_NAME=$(otool -D "$file" | grep -v -e ":$" -e "^Archive :" | head -n1)
                otool -L "$file" | tail -n +2 | grep /usr/lib/'[^/]'\*.dylib | cut -d' ' -f1 | tr -d "[:blank:]" > "$TEMPDIR_OLD"/._lib_cache
                if [ -n "$INSTALL_NAME" ]; then
                    install_name_tool -id @rpath/"$(basename "$INSTALL_NAME")" "$file"
                fi
                if otool -L "$file" | grep -q CydiaSubstrate; then
                    install_name_tool -change /Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate @rpath/libsubstrate.dylib "$file"
                fi
                if [ -f "$TEMPDIR_OLD"/._lib_cache ]; then
                    cat "$TEMPDIR_OLD"/._lib_cache | while read line; do
                        install_name_tool -change "$line" @rpath/"$(basename "$line")" "$file"
                    done
                fi
                install_name_tool -add_rpath "/usr/lib" "$file"
                install_name_tool -add_rpath "/var/jb/usr/lib" "$file"
                $LDID -s "$file" || SAFE_GUARD "Failed to sign $file with ldid" "Sign $file with ldid"
            fi
        done

        PACKAGE_FULLNAME="$(pwd)"/"$(grep Package: "$TEMPDIR_NEW"/DEBIAN/control | cut -f2 -d ' ')"-"$(grep Architecture: "$TEMPDIR_NEW"/DEBIAN/control | cut -f2 -d ' ')"
        sudo dpkg-deb -b "$TEMPDIR_NEW" ${PACKAGE_FULLNAME}_Rootless.deb

        rm -rf "$TEMPDIR_OLD" "$TEMPDIR_NEW"
        rm -rf ${PACKAGE_FULLNAME} 
        SAFE_GUARD "Failed to remove $TEMPDIR_NEW" "🍻🍻🍻🍻🍻🍻Success🍻🍻🍻🍻🍻🍻"
        ### End of rootless
    else
        SAFE_GUARD "No dylib files found"
    fi
done
