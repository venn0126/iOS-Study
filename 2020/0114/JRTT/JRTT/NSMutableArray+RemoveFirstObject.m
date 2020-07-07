//
//  NSMutableArray+RemoveFirstObject.m
//  JRTT
//
//  Created by Augus on 2020/7/6.
//  Copyright © 2020 fosafer. All rights reserved.
//



#ifndef DUMMY_CLASS
#define DUMMY_CLASS(name) \
    @interface DUMMY_CLASS_ ## name : NSObject @end \
    @implementation DUMMY_CLASS_ ## name @end
#endif

#import "NSMutableArray+RemoveFirstObject.h"
/*
 
 // Use dummy class for category in static library.
 #ifndef DUMMY_CLASS
 #define DUMMY_CLASS(name) \
     @interface DUMMY_CLASS_ ## name : NSObject @end \
     @implementation DUMMY_CLASS_ ## name @end
 #endif
  
 //使用示例:
 //UIColor+YYAdd.m
 #import "UIColor+YYAdd.h"
 DUMMY_CLASS(UIColor+YYAdd)
  
 @implementation UIColor(YYAdd)
 ...
 @end
 **/


//DUMMY_CLASS(NSMutableArray+RemoveFirstObject)


@implementation NSMutableArray (RemoveFirstObject)

- (void)fos_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
        
        NSLog(@"remove first");
        // get all items
        
        // remove frist item
        
        
    }
}

/*
 
 
 1. 只实现方法的生命
 
 2. 创建一个分类
 
 3.
 
 
 **/

//- (void)removeFirstObject {
//    
//}

@end
