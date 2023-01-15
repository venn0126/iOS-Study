#ifndef __DYLD_TEST_SUPPORT_H__
#define __DYLD_TEST_SUPPORT_H__ 1

#if __cplusplus
extern "C" {
#endif /* __cplusplus */

#include <unistd.h>
#include <mach/mach.h>
#include <mach/machine.h>
#include <dispatch/dispatch.h>

#if __cplusplus
};

// Only allow this interface for Objective-C++ due to typename and ARC issues in the default constructor

typedef void (^_dyld_test_reader_t)(int fd);
typedef void (^_dyld_test_exit_handler_t)(pid_t pid);
typedef void (^_dyld_test_crash_handler_t)(task_t task);

struct _process {
    _process();
    ~_process();
    void set_executable_path(const char* EP);
    void set_args(const char** A);
    void set_env(const char** E);
    void set_stdout_handler(_dyld_test_reader_t SOH);
    void set_stderr_handler(_dyld_test_reader_t SEH);
    void set_exit_handler(_dyld_test_exit_handler_t EH);
    void set_crash_handler(_dyld_test_crash_handler_t CH);
    void set_launch_suspended(bool S);
    void set_alt_page_size(bool PS);
    void set_launch_arch(cpu_type_t A);
    pid_t get_pid() const;
    pid_t launch();
    void *operator new(size_t size);
    void operator delete(void *ptr);
private:
    const char* executablePath;
    const char** args;
    const char** env;
    _dyld_test_reader_t stdoutHandler;
    _dyld_test_reader_t stderrHandler;
    _dyld_test_crash_handler_t crashHandler;
    _dyld_test_exit_handler_t exitHandler;
    cpu_type_t arch;
    bool suspended;
    bool altPageSize;
    pid_t pid;
};

#define STDERR_WRITER ^(int fd) {           \
    char buffer[16384];                     \
    ssize_t size = 0;                       \
    do {                                    \
        size = read(fd, &buffer[0], 16384); \
        buffer[size] = 0;                   \
        fprintf(stderr, "%s", &buffer[0]);  \
    } while (size > 0);                     \
}

#define STDOUT_WRITER ^(int fd) {           \
    char buffer[16384];                     \
    ssize_t size = 0;                       \
    do {                                    \
        size = read(fd, &buffer[0], 16384); \
        buffer[size] = 0;                   \
        fprintf(stdout, "%s", &buffer[0]);  \
    } while (size > 0);                     \
}

#endif /* __cplusplus */

#ifdef USE_PRINTF_MACROS
#include <stdio.h>
extern const char* __progname;
#define PASS(...)           printf("[PASS] %s: ", __progname); printf(__VA_ARGS__); printf("\n"); exit(0);
#define FAIL(...)           printf("[FAIL] %s: ", __progname); printf(__VA_ARGS__); printf("\n"); exit(0);
#define LOG(...)            printf("[LOG] %s: ", __progname); printf(__VA_ARGS__); printf("\n");
#define BEGIN()             printf("[BEGIN] %s\n", __progname);
#else
#define PASS(...)           _PASS(__FILE__,__LINE__,__VA_ARGS__)
#define FAIL(...)           _FAIL(__FILE__,__LINE__,__VA_ARGS__)
#define LOG(...)            _LOG(__FILE__,__LINE__,__VA_ARGS__)
#define TIMEOUT(seconds)    _TIMEOUT(__FILE__,__LINE__,seconds)
#endif
// MARK: Private implementation details

#if __cplusplus
extern "C" {
#endif  /* __cplusplus */
__attribute__((format(printf, 3, 4)))
__attribute__ ((noreturn))
extern void _PASS(const char* file, unsigned line, const char* format, ...);

__attribute__((format(printf, 3, 4)))
__attribute__ ((noreturn))
extern void _FAIL(const char* file, unsigned line, const char* format, ...);

__attribute__((format(printf, 3, 4)))
extern void _LOG(const char* file, unsigned line, const char* format, ...);

extern void _TIMEOUT(const char* file, unsigned line, uint64_t seconds);
#if __cplusplus
};
#endif  /* __cplusplus */

#endif /* __DYLD_TEST_SUPPORT_H__ */
