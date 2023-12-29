//
//  SNSecurityHelper.m
//  TestHookEncryption
//
//  Created by Augus on 2023/12/30.
//

#import "SNSecurityHelper.h"
#import <UIKit/UIKit.h>

// sysctl
#import <sys/sysctl.h>

// ptrace
#include <dlfcn.h>

// mach_task_self
#include <mach/mach.h>

// statvfs
#include <sys/statvfs.h>

// dyld
#include <mach-o/dyld.h>

@implementation SNSecurityHelper

#pragma mark - Anti Debuger

+ (BOOL)isDebugged {
    struct kinfo_proc kinfo;
    int mib[] = {CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()};
    size_t size = sizeof(kinfo);
    int sysctlRet = sysctl(mib, sizeof(mib) / sizeof(*mib), &kinfo, &size, NULL, 0);

    if (sysctlRet != 0) {
        NSLog(@"Error occured when calling sysctl(). The debugger check may not be reliable");
    }

    return (kinfo.kp_proc.p_flag & P_TRACED) != 0;
}


+ (void)denyDebugger {
    void *ptracePtr = dlsym(RTLD_SELF, "ptrace");
    if (ptracePtr != NULL) {
        typedef int (*PtraceType)(int, pid_t, caddr_t, int);
        PtraceType ptrace = (PtraceType)ptracePtr;

        // PT_DENY_ATTACH == 31
        int ptraceRet = ptrace(31, 0, 0, 0);

        if (ptraceRet != 0) {
            NSLog(@"Error occured when calling ptrace(). Denying debugger may not be reliable");
        }
    } else {
        NSLog(@"ptrace function not found. Denying debugger may not be possible");
    }
}


+ (BOOL)hasWatchpoint {
    thread_act_array_t threads = NULL;
    mach_msg_type_number_t threadCount = 0;
    BOOL hasWatchpoint = NO;
    
    if (task_threads(mach_task_self(), &threads, &threadCount) == KERN_SUCCESS) {
        arm_debug_state64_t threadStat;
        mach_msg_type_number_t count = ARM_DEBUG_STATE64_COUNT;
        
        for (mach_msg_type_number_t threadIndex = 0; threadIndex < threadCount; threadIndex++) {
            if (thread_get_state(threads[threadIndex], ARM_DEBUG_STATE64, (thread_state_t)&threadStat, &count) == KERN_SUCCESS) {
                hasWatchpoint = threadStat.__wvr[0] != 0;
                if (hasWatchpoint) { break; }
            }
        }
        vm_deallocate(mach_task_self(), (vm_address_t)threads, threadCount * sizeof(thread_act_t));
    }
    
    return hasWatchpoint;
}


#pragma mark - JailBreak Detect

+ (BOOL)canOpenURLSchemes {
    NSArray<NSString *> *urlSchemes = @[
        @"undecimus://",
        @"sileo://",
        @"zbra://",
        @"filza://",
        @"activator://"
    ];
    
    for (int i = 0; i < urlSchemes.count; i++) {
        NSString *scheme = urlSchemes[i];
        BOOL isOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:scheme]];
        if(isOpen) return isOpen;
    }
    
    return NO;
}


+ (BOOL)checkExistenceSuspiciusFiles {
    NSArray<NSString *> *paths = @[
        @"/var/mobile/Library/Preferences/ABPattern", // A-Bypass
        @"/usr/lib/ABDYLD.dylib", // A-Bypass,
        @"/usr/lib/ABSubLoader.dylib", // A-Bypass
        @"/usr/sbin/frida-server", // frida
        @"/etc/apt/sources.list.d/electra.list", // electra
        @"/etc/apt/sources.list.d/sileo.sources", // electra
        @"/.bootstrapped_electra", // electra
        @"/usr/lib/libjailbreak.dylib", // electra
        @"/jb/lzma", // electra
        @"/.cydia_no_stash", // unc0ver
        @"/.installed_unc0ver", // unc0ver
        @"/jb/offsets.plist", // unc0ver
        @"/usr/share/jailbreak/injectme.plist", // unc0ver
        @"/etc/apt/undecimus/undecimus.list", // unc0ver
        @"/var/lib/dpkg/info/mobilesubstrate.md5sums", // unc0ver
        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
        @"/jb/jailbreakd.plist", // unc0ver
        @"/jb/amfid_payload.dylib", // unc0ver
        @"/jb/libjailbreak.dylib", // unc0ver
        @"/usr/libexec/cydia/firmware.sh",
        @"/var/lib/cydia",
        @"/etc/apt",
        @"/private/var/lib/apt",
        @"/private/var/Users/",
        @"/var/log/apt",
        @"/Applications/Cydia.app",
        @"/private/var/stash",
        @"/private/var/lib/apt/",
        @"/private/var/lib/cydia",
        @"/private/var/cache/apt/",
        @"/private/var/log/syslog",
        @"/private/var/tmp/cydia.log",
        @"/Applications/Icy.app",
        @"/Applications/MxTube.app",
        @"/Applications/RockApp.app",
        @"/Applications/blackra1n.app",
        @"/Applications/SBSettings.app",
        @"/Applications/FakeCarrier.app",
        @"/Applications/WinterBoard.app",
        @"/Applications/IntelliScreen.app",
        @"/private/var/mobile/Library/SBSettings/Themes",
        @"/Library/MobileSubstrate/CydiaSubstrate.dylib",
        @"/System/Library/LaunchDaemons/com.ikey.bbot.plist",
        @"/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
        @"/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
        @"/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
        @"/Applications/Sileo.app",
        @"/var/binpack",
        @"/Library/PreferenceBundles/LibertyPref.bundle",
        @"/Library/PreferenceBundles/ShadowPreferences.bundle",
        @"/Library/PreferenceBundles/ABypassPrefs.bundle",
        @"/Library/PreferenceBundles/FlyJBPrefs.bundle",
        @"/Library/PreferenceBundles/Cephei.bundle",
        @"/Library/PreferenceBundles/SubstitutePrefs.bundle",
        @"/Library/PreferenceBundles/libhbangprefs.bundle",
        @"/usr/lib/libhooker.dylib",
        @"/usr/lib/libsubstitute.dylib",
        @"/usr/lib/substrate",
        @"/usr/lib/TweakInject",
        @"/var/binpack/Applications/loader.app", // checkra1n
        @"/Applications/FlyJB.app", // Fly JB X
        @"/Applications/Zebra.app", // Zebra
        @"/Library/BawAppie/ABypass", // ABypass
        @"/Library/MobileSubstrate/DynamicLibraries/SSLKillSwitch2.plist", // SSL Killswitch
        @"/Library/MobileSubstrate/DynamicLibraries/PreferenceLoader.plist", // PreferenceLoader
        @"/Library/MobileSubstrate/DynamicLibraries/PreferenceLoader.dylib", // PreferenceLoader
        @"/Library/MobileSubstrate/DynamicLibraries", // DynamicLibraries directory in general
        @"/var/mobile/Library/Preferences/me.jjolano.shadow.plist"
    ];
    
    NSArray *notRunEmulatorFiles = [NSArray array];
    if(![self isRunInEmulator]) {
        notRunEmulatorFiles = @[
            @"/bin/bash",
            @"/usr/sbin/sshd",
            @"/usr/libexec/ssh-keysign",
            @"/bin/sh",
            @"/etc/ssh/sshd_config",
            @"/usr/libexec/sftp-server",
            @"/usr/bin/ssh"
        ];
    }
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:paths];
    if(notRunEmulatorFiles.count > 0) {
        [tempArray addObjectsFromArray:notRunEmulatorFiles];
    }
    
    for (int i = 0; i < tempArray.count; i++) {
        NSString *path = tempArray[i];
        BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path];
        if (isExist) return isExist;
    }
    
    return NO;
}

+ (BOOL)checkSuspiciousFilesCanBeOpened {
    
    NSArray *paths = @[
        @"/.installed_unc0ver",
        @"/.bootstrapped_electra",
        @"/Applications/Cydia.app",
        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
        @"/etc/apt",
        @"/var/log/apt"
    ];
    
    NSArray *notRunEmulatorFiles = [NSArray array];
    if(![self isRunInEmulator]) {
        notRunEmulatorFiles = @[
            @"/bin/bash",
            @"/usr/sbin/sshd",
            @"/usr/bin/ssh"
        ];
    }
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:paths];
    if(notRunEmulatorFiles.count > 0) {
        [tempArray addObjectsFromArray:notRunEmulatorFiles];
    }
    
    for (int i = 0; i < tempArray.count; i++) {
        NSString *path = tempArray[i];
        BOOL isRead = [[NSFileManager defaultManager] isReadableFileAtPath:path];
        if (isRead) return isRead;
    }
    
    return NO;
}


+ (BOOL)checkSymbolicLinks {
    NSArray<NSString *> *paths = @[
        @"/var/lib/undecimus/apt", // unc0ver
        @"/Applications",
        @"/Library/Ringtones",
        @"/Library/Wallpaper",
        @"/usr/arm-apple-darwin9",
        @"/usr/include",
        @"/usr/libexec",
        @"/usr/share"
    ];
    
    for (NSString *path in paths) {
        NSError *error = nil;
        NSString *result = [[NSFileManager defaultManager] destinationOfSymbolicLinkAtPath:path error:&error];
        if ([result isKindOfClass:[NSString class]] && result.length > 0) {
            return YES;
        }
    }
    
    return NO;
}


+ (BOOL)checkDYLD {
    NSArray<NSString *> *suspiciousLibraries = @[
        @"SubstrateLoader.dylib",
        @"SSLKillSwitch2.dylib",
        @"SSLKillSwitch.dylib",
        @"MobileSubstrate.dylib",
        @"TweakInject.dylib",
        @"CydiaSubstrate",
        @"cynject",
        @"CustomWidgetIcons",
        @"PreferenceLoader",
        @"RocketBootstrap",
        @"WeeLoader",
        @"/.file",
        @"libhooker",
        @"SubstrateInserter",
        @"SubstrateBootstrap",
        @"ABypass",
        @"FlyJB",
        @"Substitute",
        @"Cephei",
        @"Electra",
        @"AppSyncUnified-FrontBoard.dylib",
        @"Shadow",
        @"FridaGadget",
        @"frida",
        @"libcycript"
    ];
    
    for (uint32_t libraryIndex = 0; libraryIndex < _dyld_image_count(); libraryIndex++) {
        const char *loadedLibraryName = _dyld_get_image_name(libraryIndex);
        if (loadedLibraryName != NULL) {
            NSString *loadedLibrary = [NSString stringWithUTF8String:loadedLibraryName];
            if (loadedLibrary != nil) {
                for (NSString *suspiciousLibrary in suspiciousLibraries) {
                    if ([loadedLibrary.lowercaseString containsString:suspiciousLibrary.lowercaseString]) {
                        return YES;
                    }
                }
            }
        }
    }
    
    return NO;
}

+ (BOOL)checkRootFlag {
    
    return [self canOpenURLSchemes] || [self checkExistenceSuspiciusFiles] || [self checkSuspiciousFilesCanBeOpened] || [self checkSymbolicLinks] || [self checkDYLD];
}



+ (BOOL)checkRuntime {
    NSDictionary *environment = [[NSProcessInfo processInfo] environment];
    return environment[@"SIMULATOR_DEVICE_NAME"] != nil;
}

+ (BOOL)checkCompile {
    #if TARGET_OS_SIMULATOR
        return YES;
    #else
        return NO;
    #endif
}

+ (BOOL)isRunInEmulator {
    
    return [self checkRuntime] || [self checkCompile];
}

@end
