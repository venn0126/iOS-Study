//
//  GTPerson.h
//  TestObjcSome
//
//  Created by Augus on 2023/1/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTPerson : NSObject
//{
//    
//    @public
//    NSInteger _age;
//}

//@property (nonatomic, assign) NSInteger age;
@property (nonatomic, copy) NSString *name;


@property (nonatomic, assign) BOOL isStronger;

@end

NS_ASSUME_NONNULL_END
