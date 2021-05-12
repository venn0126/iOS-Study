//
//  NSObject+Archive.h
//  NWModel
//
//  Created by Augus on 2021/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Archive)

/// a class to encode
/// @param aCoder a encoder instance of system
- (void)encoder:(NSCoder *)aCoder;

/// a class to decode
/// @param aDecoder a decoder instance of system
- (void)decode:(NSCoder *)aDecoder;

@end

NS_ASSUME_NONNULL_END
