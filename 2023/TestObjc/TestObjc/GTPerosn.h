//
//  GTPerosn.h
//  TestObjc
//
//  Created by Augus on 2023/1/13.
//

#import <Foundation/Foundation.h>


typedef void (^AugusBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface GTPerosn : NSObject {
    
    
    @public
    int _age;
    int _isAge;
    int age;
    int isAge;
}

@property (nonatomic, copy) AugusBlock block;
@property (nonatomic, assign) int weight;

@end

NS_ASSUME_NONNULL_END
