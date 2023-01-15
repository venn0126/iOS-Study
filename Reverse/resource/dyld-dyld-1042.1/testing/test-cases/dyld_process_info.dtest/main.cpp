
// BUILD:  $CC linksWithCF.c    -o $BUILD_DIR/linksWithCF.exe -framework CoreFoundation
// BUILD:  $CXX main.cpp          -o $BUILD_DIR/dyld_process_info.exe -DRUN_DIR="$RUN_DIR"
// BUILD:  $TASK_FOR_PID_ENABLE  $BUILD_DIR/dyld_process_info.exe

// RUN:  $SUDO ./dyld_process_info.exe

#include <Block.h>
#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>
#include <unistd.h>
#include <signal.h>
#include <spawn.h>
#include <errno.h>
#include <sys/uio.h>
#include <sys/proc.h>
#include <sys/wait.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <sys/sysctl.h>
#include <mach/machine.h>
#include <mach-o/dyld_priv.h>
#include <mach-o/dyld_process_info.h>
#include <Availability.h>

#include "test_support.h"


static void inspectProcess(task_t task, bool launchedSuspended, bool expectCF, bool forceIOSMac)
{
    kern_return_t result;
    dyld_process_info info = _dyld_process_info_create(task, 0, &result);
    if (result != KERN_SUCCESS) {
        FAIL("dyld_process_info() should succeed, get return code %d", result);
    }
    if (info == NULL) {
        FAIL("dyld_process_info(task, 0) alwats return a value");
    }

    dyld_process_state_info stateInfo;
    bzero(&stateInfo, sizeof(stateInfo));
    _dyld_process_info_get_state(info, &stateInfo);
    if ((stateInfo.dyldState == dyld_process_state_not_started) != launchedSuspended) {
        FAIL("If launchSuspended then stateInfo.dyldState shoould be dyld_process_state_not_started");
    }
    if ( !launchedSuspended ) {
        if (stateInfo.dyldState < dyld_process_state_libSystem_initialized) { FAIL("libSystem should be initalized by now"); }
        if (stateInfo.imageCount == 0) { return FAIL("image count should be > 0"); }
        if (stateInfo.initialImageCount == 0) { return FAIL("initial image count should be > 0"); }
        if (stateInfo.imageCount < stateInfo.initialImageCount) { FAIL("image count should be >= initial image count"); }
    }

    dyld_platform_t remotePlatform = _dyld_process_info_get_platform(info);
    dyld_platform_t localPlatform = dyld_get_active_platform();
    if (launchedSuspended) {
        if (remotePlatform != 0)  {
            FAIL("_dyld_process_info_get_platform() should be 0 for launchSuspended processes");
        }
    } else if (forceIOSMac && (remotePlatform != PLATFORM_MACCATALYST)) {
        FAIL("_dyld_process_info_get_platform(%u) should be PLATFORM_MACCATALYST", remotePlatform);
    } else if (!forceIOSMac && (remotePlatform != localPlatform)) {
        FAIL("_dyld_process_info_get_platform(%u) should be the same dyld_get_active_platform(%u)",
             remotePlatform, localPlatform);
    }

    __block bool foundDyld = false;
    __block bool foundMain = false;
    __block bool foundCF = false;
    _dyld_process_info_for_each_image(info, ^(uint64_t machHeaderAddress, const uuid_t uuid, const char* path) {
        if ( strstr(path, "/dyld") != NULL )
            foundDyld = true;
        if ( strstr(path, "/linksWithCF.exe") != NULL )
            foundMain = true;
        if ( strstr(path, "/dyld_process_info.exe") != NULL )
            foundMain = true;
        if ( strstr(path, "/CoreFoundation.framework/") != NULL )
            foundCF = true;
    });
    if (!foundDyld) { FAIL("dyld should always be in the image list"); }
    if (!foundMain) { FAIL("The main executable should always be in the image list"); }
    if (expectCF && !foundCF) { FAIL("CF should be in the image list"); }

     _dyld_process_info_release(info);
}

#if __x86_64__
cpu_type_t otherArch[] = { CPU_TYPE_I386 };
#elif __i386__
cpu_type_t otherArch[] = { CPU_TYPE_X86_64 };
#elif __arm64__
cpu_type_t otherArch[] = { CPU_TYPE_ARM };
#elif __arm__
cpu_type_t otherArch[] = { CPU_TYPE_ARM64 };
#endif


static void launchTest(bool launchOtherArch, bool launchSuspended, bool forceIOSMac, bool altPageSize)
{
    if (altPageSize) {
        int supported = 0;
        size_t supported_size = sizeof(size_t);
        int r = sysctlbyname("debug.vm_mixed_pagesize_supported", &supported, &supported_size, NULL, 0);
        if (r != 0 || !supported) { return; }
    }
    LOG("launchTest %s", launchSuspended ? "suspended" : "unsuspended");
    const char * program = RUN_DIR "/linksWithCF.exe";

    _process process;
    process.set_executable_path(RUN_DIR "/linksWithCF.exe");
    process.set_launch_suspended(launchSuspended);
    if (altPageSize) {
        process.set_alt_page_size(true);
    }
    if (forceIOSMac) {
        LOG("Launching native");
        const char* env[] = { "TEST_OUTPUT=None", "DYLD_FORCE_PLATFORM=6", NULL};
        process.set_env(env);
    } else {
        LOG("Launching iOSMac");
        const char* env[] = { "TEST_OUTPUT=None", NULL};
        process.set_env(env);
    }
    pid_t pid = process.launch();
    LOG("launchTest pid: %d", pid);

    task_t task;
    if (task_read_for_pid(mach_task_self(), pid, &task) != KERN_SUCCESS) {
        FAIL("task_read_for_pid() failed");
    }
    LOG("launchTest task: %u", task);

    // wait until process is up and has suspended itself
    if (!launchSuspended) {
        dispatch_queue_t queue = dispatch_queue_create("com.apple.test.dyld_process_info", NULL);
        // We do this instead of using a dispatch_semaphore to prevent priority inversions
        dispatch_block_t oneShotSemaphore = dispatch_block_create(DISPATCH_BLOCK_INHERIT_QOS_CLASS, ^{});
        dispatch_source_t signalSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, SIGUSR1,
                                                                0, queue);
        dispatch_source_set_event_handler(signalSource, ^{
            LOG("Recieved signal");
            oneShotSemaphore();
            dispatch_source_cancel(signalSource);
        });
        dispatch_resume(signalSource);
        dispatch_block_wait(oneShotSemaphore, DISPATCH_TIME_FOREVER);
    }
    LOG("task running");

    inspectProcess(task, launchSuspended, !launchSuspended, forceIOSMac);
}

int main(int argc, const char* argv[], const char* envp[], const char* apple[]) {
    signal(SIGUSR1, SIG_IGN);
    launchTest(false, false, false, false);
    launchTest(false, true, false, false);
#if __MAC_OS_X_VERSION_MIN_REQUIRED
    launchTest(false, false, true, false);
    launchTest(false, true, true, false);
    launchTest(false, false, false, true);
    launchTest(false, true, false, true);
    //FIXME: This functionality is broken, but it is an edge case no one should ever hit
    //launchTest(true, true, true);
#endif
    dispatch_async( dispatch_get_main_queue(), ^{
        inspectProcess(mach_task_self(), false, false, false);
        PASS("Success");
    });
    dispatch_main();
}
