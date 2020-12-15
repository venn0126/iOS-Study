//
//  FSGuideItem.m
//  fosFloatView
//
//  Created by Augus on 2020/11/18.
//

#import "FSGuideItem.h"

@implementation FSGuideItem

//MARK: - Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.annotatedView = nil;
        self.highlightFrameOfAnnotated = CGRectZero;
        self.cornerRadiusOfAnnotated = 0.0;
        self.spacingBetweenAnnotationAndAnnotated = 42.0;
        self.offsetOfIndicator = CGPointZero;
        self.shadowColor = UIColor.blackColor;
        
        self.annotationText = @"注解文字";
        self.annotationTitle = @"标题";
        self.previousButtonTitle = nil;
        self.nextButtonTitle = nil;
        self.iconImageName = nil;
        self.backgroundImageName = nil;
    }
    return self;
}

@end
