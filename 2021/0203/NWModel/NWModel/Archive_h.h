//
//  Archive_h.h
//  NWModel
//
//  Created by Augus on 2021/4/2.
//

#ifndef Archive_h_h
#define Archive_h_h

#import "NSObject+Archive.h"

#define AchiveImplemention \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder {\
    if (self = [super init]) {\
        [self decode:aDecoder];\
    }\
    return self;\
}\
- (void)encodeWithCoder:(NSCoder *)aCoder {\
    [self encode:aCoder];\
}
#endif /* Archive_h_h */
