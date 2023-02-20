//
//  GTOneTapSentMessageManger.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/15.
//

#import "GTOneTapSentMessageManger.h"
#import "GTControllableCThread.h"

@interface GTOneTapSentMessageManger ()

@property (nonatomic, strong) NSTimer *augusTimer;
@property (nonatomic, strong) GTControllableCThread *augusThread;

@end

@implementation GTOneTapSentMessageManger

+ (instancetype)sharedInstance {
    
    
    static GTOneTapSentMessageManger *manger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manger = [[GTOneTapSentMessageManger alloc] init];
    });
    
    return manger;
}

- (void)gt_fetchConversationIdForSnapchatter:(GTOneTapSentMessageBlock)completion {
    
    if(!completion) return;
    if([GTOneTapSentMessageManger sharedInstance].sections.count != 28) return;
    
    /*
     
     // -[SCChatConversationDataCoordinator _fetchConversationIdAndMetadataForSnapchatter:(SCSnapchatter *)completion:(void(^)(_Bool, NSString *, SCChatActiveConversationMetadata *))]
     
     
     [#0x110c33860 _fetchConversationIdAndMetadataForSnapchatter:#0x282ece250 completion: ^void(BOOL isSuccess, NSString *str, SCChatActiveConversationMetadata *data) { array.push(str) }]
     
     
     
     
     
     */
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });

    
}

- (void)gt_startTimerWithTimeInterval:(NSTimeInterval)interval block:(void (NS_SWIFT_SENDABLE ^)(NSTimer *timer))block {

    if(!self.augusThread) {
        self.augusThread = [[GTControllableCThread alloc] init];
    }
    [self.augusThread gt_cexecuteTask:^{
        if(!self->_augusTimer) {
            self->_augusTimer = [NSTimer timerWithTimeInterval:interval repeats:YES block:block];
            [[NSRunLoop currentRunLoop] addTimer:self->_augusTimer forMode:NSDefaultRunLoopMode];
        }
    }];
    
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:nil];
}



- (void)gt_stopTimer {
    
    [_augusTimer invalidate];
    _augusTimer = nil;

}


@end
