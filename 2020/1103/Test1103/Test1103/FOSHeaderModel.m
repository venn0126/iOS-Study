//
//  FOSHeaderModel.m
//  offCompoundDemo
//
//  Created by Augus on 2020/2/11.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "FOSHeaderModel.h"

@implementation FOSHeaderModel

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.contractId = [coder decodeObjectForKey:@"contractId"];
        self.productInfo = [coder decodeIntegerForKey:@"productInfo"];
        self.speechData = [coder decodeObjectForKey:@"speechData"];
        self.imageData = [coder decodeObjectForKey:@"imageData"];
        self.faceInfo = [coder decodeObjectForKey:@"faceInfo"];
        self.slientContractId = [coder decodeObjectForKey:@"slientContractId"];
        self.slientProductInfo = [coder decodeObjectForKey:@"slientProductInfo"];
        self.accessToken = [coder decodeObjectForKey:@"accessToken"];
    }
    return self;
}



- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.contractId forKey:@"contractId"];
    [coder encodeInteger:self.productInfo forKey:@"productInfo"];
    [coder encodeObject:self.speechData forKey:@"speechData"];
    [coder encodeObject:self.imageData forKey:@"imageData"];
    [coder encodeObject:self.faceInfo forKey:@"faceInfo"];
    [coder encodeObject:self.slientContractId forKey:@"slientContractId"];
    [coder encodeObject:self.slientProductInfo forKey:@"slientProductInfo"];
    [coder encodeObject:self.accessToken forKey:@"accessToken"];


}

@end
