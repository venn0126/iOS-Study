//
//  SNDispatchQueuePool.m
//  NWUITest
//
//  Created by Augus on 2021/7/6.
//

#import "SNDispatchQueuePool.h"
#import <UIKit/UIKit.h>
//#import <libkern/OSAtomic.h>
#import <stdatomic.h>


static const NSUInteger kMaxQueueCount = 32;

static inline dispatch_queue_priority_t NSQualityOfServiceToDispatchPriority(NSQualityOfService qos) {

    switch (qos) {
        case NSQualityOfServiceUserInteractive: return DISPATCH_QUEUE_PRIORITY_HIGH;
        case NSQualityOfServiceUserInitiated: return DISPATCH_QUEUE_PRIORITY_HIGH;
        case NSQualityOfServiceUtility: return DISPATCH_QUEUE_PRIORITY_LOW;
        case NSQualityOfServiceBackground: return DISPATCH_QUEUE_PRIORITY_BACKGROUND;
        case NSQualityOfServiceDefault: return DISPATCH_QUEUE_PRIORITY_DEFAULT;
        default: return  DISPATCH_QUEUE_PRIORITY_DEFAULT;
    }

}


static inline qos_class_t NSQualityOfServiceToQosClass(NSQualityOfService qos) {
    
    switch (qos) {
        case NSQualityOfServiceUserInteractive: return QOS_CLASS_USER_INTERACTIVE;
        case NSQualityOfServiceUserInitiated: return QOS_CLASS_USER_INITIATED;
        case NSQualityOfServiceUtility: return QOS_CLASS_UTILITY;
        case NSQualityOfServiceBackground: return QOS_CLASS_BACKGROUND;
        case NSQualityOfServiceDefault: return QOS_CLASS_DEFAULT;
        default: return QOS_CLASS_UNSPECIFIED;;
    }
}


typedef struct {
    const char *name;
    void **queues;
    uint32_t queueCount;
    atomic_int counter;
} SNDispatchContext;


static SNDispatchContext *SNDispatchContextCreate(const char *name,
                                                  uint32_t queueCount,
                                                  NSQualityOfService qos) {
    SNDispatchContext *context = calloc(1, sizeof(SNDispatchContext));
    if (!context) return NULL;
    
    context->queues = calloc(queueCount, sizeof(void *));
    if (!context->queues) {
        free(context);
        return NULL;
    }
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        dispatch_qos_class_t qosClass = NSQualityOfServiceToQosClass(qos);
        for (NSUInteger i = 0; i < queueCount; i++) {
            dispatch_queue_attr_t attr = dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, qosClass, 0);
            dispatch_queue_t queue = dispatch_queue_create(name, attr);
            context->queues[i] = (__bridge_retained void *)(queue);
        }
    } else {
        long identifier = NSQualityOfServiceToDispatchPriority(qos);
        for (NSUInteger i = 0; i < queueCount; i++) {
            dispatch_queue_t queue = dispatch_queue_create(name, DISPATCH_QUEUE_SERIAL);
            dispatch_set_target_queue(queue, dispatch_get_global_queue(identifier, 0));
            context->queues[i] = (__bridge_retained void *)(queue);

        }
    }
    
    context->queueCount = queueCount;
    if (name) {
        context->name = name;
    }
    
    return context;
}


static void SNDispatchContextRelease(SNDispatchContext *context) {
    
    if (!context) {
        return;
    }
    
    if (context->queues) {
        for (NSUInteger i = 0; i < context->queueCount; i++) {
            void *queuePtr = context->queues[i];
            dispatch_queue_t queue = (__bridge dispatch_queue_t)(queuePtr);
            const char *name = dispatch_queue_get_label(queue);
            if (name) {
                strlen(name);
            }
            queue = nil;
            
        }
        free(context->queues);
        context->queues = NULL;
    }
    if (context->name) {
        free((void *)context->name);
    }
    free(context);
}

static dispatch_queue_t SNDispatchContextGetQueue(SNDispatchContext *context) {
     
//    uint32_t counter = (uint32_t)OSAtomicIncrement32(&context->counter);

    atomic_fetch_add_explicit(&context->counter,1,memory_order_relaxed);
    void *queue = context->queues[context->counter % context->queueCount];
    return (__bridge dispatch_queue_t)(queue);
}

static SNDispatchContext *SNDispatchGetContextTokenForName(SNDispatchContext context[],int idx,const char *name,NSQualityOfService qos) {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
        count = count < 1 ? 1 : count > kMaxQueueCount ? kMaxQueueCount : count;
        context[idx] = *SNDispatchContextCreate(name, count, qos);
    });
    return &context[idx];
}

static SNDispatchContext *SNDispatchContextGetForQos(NSQualityOfService qos) {
    
    static SNDispatchContext *context[5] = {0};
    switch (qos) {
        case NSQualityOfServiceUserInteractive: {
            
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
//                count = count < 1 ? 1 : count > kMaxQueueCount ? kMaxQueueCount : count;
//                context[0] = SNDispatchContextCreate("com.soho.news.user-interactive", count, qos);
//            });
//            return context[0];
            return SNDispatchGetContextTokenForName((SNDispatchContext *)context, 0, "com.soho.news.user-interactive", qos);

        }break;
            
        case NSQualityOfServiceUserInitiated: {
            
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
//                count = count < 1 ? 1 : count > kMaxQueueCount ? kMaxQueueCount : count;
//                context[1] = SNDispatchContextCreate("com.soho.news.user-initiated", count, qos);
//            });
//            return context[1];
            return SNDispatchGetContextTokenForName((SNDispatchContext *)context, 1, "com.soho.news.user-initiated", qos);

            
        }break;
            
        case NSQualityOfServiceUtility: {
            
            
            return SNDispatchGetContextTokenForName((SNDispatchContext *)context, 2, "com.soho.news.utility", qos);
            
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
//                count = count < 1 ? 1 : count > kMaxQueueCount ? kMaxQueueCount : count;
//                context[2] = SNDispatchContextCreate("com.soho.news.utility", count, qos);
//            });
//            return context[2];
            
            
        }break;
        case NSQualityOfServiceBackground: {
            
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
//                count = count < 1 ? 1 : count > kMaxQueueCount ? kMaxQueueCount : count;
//                context[3] = SNDispatchContextCreate("com.soho.news.background", count, qos);
//            });
//            return context[3];
            return SNDispatchGetContextTokenForName((SNDispatchContext *)context, 3, "com.soho.news.background", qos);

        }break;
        case NSQualityOfServiceDefault:
        default:{
//            static dispatch_once_t onceToken;
//            dispatch_once(&onceToken, ^{
//                int count = (int)[NSProcessInfo processInfo].activeProcessorCount;
//                count = count < 1 ? 1 : count > kMaxQueueCount ? kMaxQueueCount : count;
//                context[4] = SNDispatchContextCreate("com.soho.news.default", count, qos);
//            });
//            return context[4];
            return SNDispatchGetContextTokenForName((SNDispatchContext *)context, 4, "com.soho.news.default", qos);

        }break;
    }
}


@implementation SNDispatchQueuePool{
    
    @public
    SNDispatchContext *_context;
}

- (void)dealloc {
    if (_context) {
        SNDispatchContextRelease(_context);
        _context = NULL;
    }
}


- (instancetype)initWithContext:(SNDispatchContext *)context {
    self = [super init];
    if (!context) {
        return nil;
    }
    _context = context;
    _name = context->name ? [NSString stringWithUTF8String:_context->name] : nil;
    return self;
}


- (instancetype)initWithName:(NSString *)name queueCount:(NSUInteger)queueCount qos:(NSQualityOfService)qos {
    if (queueCount == 0 || queueCount > kMaxQueueCount) {
        return nil;
    }
    self = [super init];
    _context = SNDispatchContextCreate(name.UTF8String, (uint32_t)queueCount, qos);
    if (!_context) {
        return nil;
    }
    _name = name;
    return self;
}

- (dispatch_queue_t)queue {
    return SNDispatchContextGetQueue(_context);;
}


+ (instancetype)defaultPoolForQos:(NSQualityOfService)qos {
    
    switch (qos) {
        case NSQualityOfServiceUserInteractive:{
            return SNDispatchGetPoolForQos(qos);
        }break;
        case NSQualityOfServiceUserInitiated:{
            return SNDispatchGetPoolForQos(qos);
        }break;
        case NSQualityOfServiceUtility:{
            return SNDispatchGetPoolForQos(qos);
        }break;
        case NSQualityOfServiceBackground:{
            return SNDispatchGetPoolForQos(qos);
        }break;
            
        case NSQualityOfServiceDefault:
        default:{
            return SNDispatchGetPoolForQos(NSQualityOfServiceDefault);
        }break;
    }
}


static SNDispatchQueuePool *SNDispatchGetPoolForQos(NSOperationQualityOfService qos) {
    static SNDispatchQueuePool *pool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pool = [[SNDispatchQueuePool alloc] initWithContext:SNDispatchContextGetForQos(qos)];
    });
    return pool;
}

@end
