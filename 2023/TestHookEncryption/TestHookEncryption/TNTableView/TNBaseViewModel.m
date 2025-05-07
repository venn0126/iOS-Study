//
//  TNBaseViewModel.m
//  TestHookEncryption
//
//  Created by Augus on 2025/5/8.
//

#import "TNBaseViewModel.h"

@implementation TNBaseViewModel

- (void)reloadData {
    // 子类重写
}

- (void)notifyDataChanged {
    // 子类可选
    if (self.onDataChanged) {
        self.onDataChanged();
    }
}

@end
