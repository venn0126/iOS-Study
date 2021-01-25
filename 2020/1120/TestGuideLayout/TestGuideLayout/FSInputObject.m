//
//  FSInputObject.m
//  TestGuideLayout
//
//  Created by Augus on 2021/1/19.
//

#import "FSInputObject.h"

NSString * kInputObjectTextDidChangeNotification = @"kInputObjectTextDidChangeNotification";

@implementation FSInputObject

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)hasText {
    return self.text.length;
}

- (void)insertText:(NSString *)text {
    NSString *seltText = self.text ? self.text : @"";
    self.text = [seltText stringByAppendingString:text];
    [[NSNotificationCenter defaultCenter] postNotificationName:kInputObjectTextDidChangeNotification object:self];
}

- (void)deleteBackward {
    if (self.text.length > 0) {
        self.text = [self.text substringToIndex:self.text.length - 1];
    }else {
        self.text = nil;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInputObjectTextDidChangeNotification object:self];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
