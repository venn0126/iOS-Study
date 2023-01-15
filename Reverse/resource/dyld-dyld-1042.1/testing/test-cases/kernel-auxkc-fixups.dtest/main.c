
// BOOT_ARGS: amfi=3 cs_enforcement_disable=1

// Create the base kernel collection
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CP extensions/kernel-export.kext/Info.plist $BUILD_DIR/extensions/kernel-export-kext/Info.plist
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CC main.c -o $BUILD_DIR/kernel-auxkc-fixups.exe -Wl,-static -mkernel -nostdlib -Wl,-add_split_seg_info -Wl,-e,__start -Wl,-pie -Wl,-pagezero_size,0x0 -Wl,-install_name,/usr/lib/swift/split.seg.v2.hack -fno-stack-protector -fno-builtin -ffreestanding -Wl,-segprot,__HIB,rx,rx -Wl,-image_base,0x8000 -Wl,-segaddr,__HIB,0x4000 -fno-ptrauth-function-pointer-type-discrimination -O2
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CC kernel-export.c -o $BUILD_DIR/extensions/kernel-export-kext/kernel-export -Wl,-kext -mkernel -nostdlib -Wl,-add_split_seg_info -Wl,-install_name,/usr/lib/swift/split.seg.v2.hack -fno-ptrauth-function-pointer-type-discrimination -O2
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $APP_CACHE_UTIL -create-kernel-collection $BUILD_DIR/kernel.kc -kernel $BUILD_DIR/kernel-auxkc-fixups.exe -extensions $BUILD_DIR/extensions -bundle-id com.apple.kernel.export $DEPENDS_ON_ARG $BUILD_DIR/extensions/kernel-export-kext/Info.plist $DEPENDS_ON_ARG $BUILD_DIR/extensions/kernel-export-kext/kernel-export

// Create the aux kernel collection
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CP extensions/foo.kext/Info.plist $BUILD_DIR/extensions/foo-kext/Info.plist
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CP extensions/bar.kext/Info.plist $BUILD_DIR/extensions/bar-kext/Info.plist
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CC foo.c -o $BUILD_DIR/extensions/foo-kext/foo -Wl,-kext -mkernel -nostdlib -Wl,-add_split_seg_info -Wl,-install_name,/usr/lib/swift/split.seg.v2.hack -fno-ptrauth-function-pointer-type-discrimination -O2
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $CC bar.c -o $BUILD_DIR/extensions/bar-kext/bar -Wl,-kext -mkernel -nostdlib -Wl,-add_split_seg_info -Wl,-install_name,/usr/lib/swift/split.seg.v2.hack -fno-ptrauth-function-pointer-type-discrimination -O2
// BUILD(macos,ios,tvos,bridgeos|x86_64,arm64,arm64e):  $APP_CACHE_UTIL -create-aux-kernel-collection $BUILD_DIR/aux.kc -kernel-collection $BUILD_DIR/kernel.kc -extensions $BUILD_DIR/extensions  -bundle-id com.apple.foo $DEPENDS_ON_ARG $BUILD_DIR/extensions/foo-kext/Info.plist $DEPENDS_ON_ARG $BUILD_DIR/extensions/bar-kext/Info.plist $DEPENDS_ON_ARG $BUILD_DIR/extensions/foo-kext/foo $DEPENDS_ON_ARG $BUILD_DIR/extensions/bar-kext/bar

// BUILD(watchos):

// RUN_STATIC:    $RUN_STATIC $RUN_DIR/kernel.kc - - $RUN_DIR/aux.kc

#include "../kernel-test-runner.h"
#include "../kernel-fixups.h"
#include "../kernel-classic-relocs.h"
#include "../kernel-helpers.h"

#define printf(...) hostFuncs->printf(__VA_ARGS__)

int x = 1;
int *g = &x;

#if __x86_64__
__attribute__((section(("__HIB, __text"))))
#else
__attribute__((section(("__TEXT_EXEC, __text"))))
#endif
int _start(const TestRunnerFunctions* hostFuncs)
{
    const void* slideBasePointers[4];
    slideBasePointers[0] = hostFuncs->basePointers[0];
    slideBasePointers[1] = hostFuncs->basePointers[1];
    slideBasePointers[2] = hostFuncs->basePointers[2];
    slideBasePointers[3] = hostFuncs->basePointers[3];
    int slideReturnCode = slide(hostFuncs->mhs[0], slideBasePointers, hostFuncs->printf);
    if ( slideReturnCode != 0 ) {
        FAIL("mhs[0] slide = %d\n", slideReturnCode);
        return 0;
    }

    int slideClassicReturnCode = slideClassic(hostFuncs->mhs[0], hostFuncs->printf);
    if ( slideClassicReturnCode != 0 ) {
        FAIL("mhs[0] slide classic = %d\n", slideClassicReturnCode);
        return 0;
    }

    if ( g[0] != x ) {
    	FAIL("g[0] != x, %d != %d\n", g[0], x);
    	return 0;
    }

    // First slide the auxKC using the top level fixups.  These handle the branch GOTs
    slideReturnCode = slide(hostFuncs->mhs[3], slideBasePointers, hostFuncs->printf);
    if ( slideReturnCode != 0 ) {
        FAIL("mhs[3] slide = %d\n", slideReturnCode);
        return 0;
    }

#if __x86_64__
    // On x86 only, slide the auxKC individually
    // Then slide pageable using the fixups attached to the kexts own mach headers
    slideReturnCode = slideKextsInsideKernelCollection(hostFuncs->mhs[3], slideBasePointers, hostFuncs->printf, hostFuncs);
    if ( slideReturnCode != 0 ) {
        FAIL("mhs[3] slide = %d\n", slideReturnCode);
        return 0;
    }
#endif

    // If we have any mod init funcs, then lets run them now
    int runModInitFuncs = runAllModInitFunctionsForAppCache(hostFuncs->mhs[3], hostFuncs->printf, hostFuncs);
    if ( runModInitFuncs != 0 ) {
        FAIL("runModInitFuncs = %d\n", runModInitFuncs);
        return 0;
    }

    PASS("Success");
    return 0;
}


