//
//  GTAugusView.m
//  TestObjcSome
//
//  Created by Augus on 2023/2/17.
//

#import "GTAugusView.h"

@implementation GTAugusView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    if(!self) return nil;
    
//    self canPerformAction:@selector(_handleGestureRecognizer:) withSender:<#(nullable id)#>

    
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"name"]) {
        NSLog(@"augus view person name change %@",change);
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)dealloc {
    
    NSLog(@"%s",__func__);
}
@end
