//
//  NWPerson.m
//  YPYDemo
//
//  Created by Augus on 2021/3/13.
//

#import "NWPerson.h"

@implementation NWPerson


- (NWPerson * _Nonnull (^)(void))driveCar {
    
    return ^(void){
        
        NSLog(@"drive car");
        return self;
    };
}

- (instancetype)with {
    
    NSLog(@"with");
    
//    if (!self) {
//        self = [NWPerson new];
//    }
    return self;
}

//- (NWPerson * _Nonnull (^)(void))eatFood:(void (^)(void))completed {
//
//    return ^(void){
//        completed();
//        return self;
//    };
//}

- (NWPerson * _Nonnull (^)(void))eatFood {
    return ^(void){
        NSLog(@"eat food");
        return self;
    };
}

- (NWPerson * _Nonnull (^)(int))add {
    
    
    return ^NWPerson *(int value) {
        
        _result += value;
        
        return self;
    };
}

- (NWPerson * _Nonnull (^)(int))plus {
    return ^NWPerson *(int value) {
        
        _result -= value;
        
        return self;
    };
}

- (NWPerson * _Nonnull (^)(int))muilt {
    return ^NWPerson *(int value) {
        
        _result *= value;
        
        return self;
    };
}

- (NWPerson * _Nonnull (^)(int))divide {
    return ^NWPerson *(int value) {
        
        _result /= value;
        
        return self;
    };
}


+ (int)makeCaculators:(void (^)(NWPerson * _Nonnull))make {
        
    NWPerson *person = [NWPerson new];
    make(person);
    return person.result;
}


- (NWPerson *)caculator:(int (^)(int))caculator {
    int res = caculator(self.result);
    NSLog(@"111---%d",res);
    return self;
}



- (NWPerson *)equal:(BOOL (^)(int))operation {

    self.nwEqual = operation(12);
    return self;
}

+ (void)load {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}

- (void)personPrint {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));
}

- (Class)class {
    
    return nil;
}
+ (Class)class {
    
    
//   BOOL res = [self isKindOfClass:[NWPerson class]];
//    [NSObject class] 
    
    
    return self;
}

+ (void)foo {
    
    NSLog(@"%@ : %@",@(__PRETTY_FUNCTION__),@(__LINE__));

}
 
@end
