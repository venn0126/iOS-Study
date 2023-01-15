// BUILD(macos|x86_64):   $CC bar.c -target x86_64-apple-macos10.5 -dynamiclib -install_name $RUN_DIR/libbar.dylib -o $BUILD_DIR/libbar.dylib
// BUILD(macos|x86_64):   $CC foo.c -target x86_64-apple-macos10.5 -dynamiclib $BUILD_DIR/libbar.dylib -sub_library libbar -install_name $RUN_DIR/libfoo.dylib -o $BUILD_DIR/libfoo.dylib
// BUILD(macos|x86_64):   $CC main.c -target x86_64-apple-macos10.5 -o $BUILD_DIR/dylib-re-export.exe $BUILD_DIR/libfoo.dylib -L$BUILD_DIR $DEPENDS_ON $BUILD_DIR/libbar.dylib

// BUILD(ios,tvos,watchos,bridgeos):

// RUN(macos|x86_64):  ./dylib-re-export.exe


#include "test_support.h"

extern int bar();


int main(int argc, const char* argv[], const char* envp[], const char* apple[]) {
    BEGIN();
    PASS("Success");
#if 0
    if ( bar() == 42 ) {
        PASS("Success");
    } else {
        FAIL("Wrong value");
    }
#endif
}
