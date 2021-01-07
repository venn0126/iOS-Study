//
//  UIView+FosOperation.m
//  TestGuideLayout
//
//  Created by Augus on 2020/12/22.
//

#import "UIView+FosOperation.h"
#import <objc/runtime.h>


static const NSString *fosOperationKey = @"fosOperationKey";

@implementation UIView (FosOperation)


- (void)setFosOperation:(NSMutableDictionary *)fosOperation {
    
    objc_setAssociatedObject(self, &fosOperationKey, fosOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSMutableDictionary *)fosOperation {
       
    return  objc_getAssociatedObject(self, &fosOperationKey);
    
    
    
}

@end
