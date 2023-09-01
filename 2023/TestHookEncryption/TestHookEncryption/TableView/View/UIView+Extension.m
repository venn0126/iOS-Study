//
//  UIView+Extension.m
//  TestHookEncryption
//
//  Created by Augus on 2023/8/15.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (void)setSt_frame:(UIView *(^)(CGRect))st_frame{}

-(UIView *(^)(CGRect))st_frame{
    return ^(CGRect rect){
        self.frame = rect;
        return self;
    };
}
-(void)setSt_backgroundColor:(UIView *(^)(UIColor *))set_backgroundColor{}

-(UIView *(^)(UIColor *))st_backgroundColor{
    
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}
#pragma mark 直接给控件frame赋值

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGPoint)origin{
    return self.frame.origin;
}

-(void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


-(CGSize)size{
    return self.frame.size;
}
-(void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


-(CGFloat)centerX{
    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}


-(CGFloat)centerY{
    return self.center.y;
}


-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}


- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)left {
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

@end


@implementation UIButton (UIButton___Extension)
#pragma mark Nomal状态button下各属性重写
//image
-(void)setSt_nomalImage:(UIButton *(^)(NSString *))st_nomalImage{}
-(UIButton *(^)(NSString *))st_nomalImage{
    return ^(NSString *str){
        [self setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        return self;
    };
}
////title
-(void)setSt_nomalTitle:(UIButton *(^)(NSString *))st_nomalTitle{}
-(UIButton *(^)(NSString *))st_nomalTitle{
    return ^(NSString *str){
        [self setTitle:str forState:UIControlStateNormal];
        return self;
    };
}

////titleColor
-(void)setSt_nomalTitleColor:(UIButton *(^)(UIColor *))st_nomalTitleColor{}
-(UIButton *(^)(UIColor *))st_nomalTitleColor{
    return ^(UIColor *color){
        [self setTitleColor:color forState:UIControlStateNormal];
        return self;
    };
}

////backgroudImage
-(void)setSt_nomalBackgroundImage:(UIButton *(^)(NSString *))st_nomalBackgroundImage{}
-(UIButton *(^)(NSString *))st_nomalBackgroundImage{
    return ^(NSString *str ){
        [self setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
        return self;
    };
}

#pragma mark Highlighted状态button下各属性重写
//image
-(void)setSt_highlightedImage:(UIButton *(^)(NSString *))st_highlightedImage{}
-(UIButton *(^)(NSString *))st_highlightedImage{
    return ^(NSString *str){
        [self setImage:[UIImage imageNamed:str] forState:UIControlStateHighlighted];
        return self;
    };
}
////title
-(void)setSt_highlightedTitle:(UIButton *(^)(NSString *))st_highlightedTitle{}
-(UIButton *(^)(NSString *))st_highlightedTitle{
    return ^(NSString *str){
        [self setTitle:str forState:UIControlStateHighlighted];
        return self;
    };
}

////titleColor
-(void)setSt_highlightedTitleColor:(UIButton *(^)(UIColor *))st_highlightedTitleColor{}
-(UIButton *(^)(UIColor *))st_highlightedTitleColor{
    return ^(UIColor *color){
        [self setTitleColor:color forState:UIControlStateHighlighted];
        return self;
    };
}

////backgroudImage
-(void)setSt_highlightedBackgroundImage:(UIButton *(^)(NSString *))st_highlightedBackgroundImage{}
-(UIButton *(^)(NSString *))st_highlightedBackgroundImage{
    return ^(NSString *str ){
        [self setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateHighlighted];
        return self;
    };
}

#pragma mark Selected状态button下各属性重写
//image
-(void)setSt_selectedImage:(UIButton *(^)(NSString *))st_selectedImage{}
-(UIButton *(^)(NSString *))st_selectedImage{
    return ^(NSString *str){
        [self setImage:[UIImage imageNamed:str] forState:UIControlStateSelected];
        return self;
    };
}
////title
-(void)setSt_selectedTitle:(UIButton *(^)(NSString *))st_selectedTitle{}
-(UIButton *(^)(NSString *))st_selectedTitle{
    return ^(NSString *str){
        [self setTitle:str forState:UIControlStateSelected];
        return self;
    };
}

////titleColor
-(void)setSt_selectedTitleColor:(UIButton *(^)(UIColor *))st_selectedTitleColor{}
-(UIButton *(^)(UIColor *))st_selectedTitleColor{
    return ^(UIColor *color){
        [self setTitleColor:color forState:UIControlStateSelected];
        return self;
    };
}

////backgroudImage
-(void)setSt_selectedBackgroundImage:(UIButton *(^)(NSString *))st_selectedBackgroundImage{}
-(UIButton *(^)(NSString *))st_selectedBackgroundImage{
    return ^(NSString *str ){
        [self setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateSelected];
        return self;
    };
}

#pragma mark disabled状态button下各属性重写
//image
-(void)setSt_disabledImage:(UIButton *(^)(NSString *))st_disabledImage{}
-(UIButton *(^)(NSString *))st_disabledImage{
    return ^(NSString *str){
        [self setImage:[UIImage imageNamed:str] forState:UIControlStateDisabled];
        return self;
    };
}
////title
-(void)setSt_disabledTitle:(UIButton *(^)(NSString *))st_disabledTitle{}
-(UIButton *(^)(NSString *))st_disabledTitle{
    return ^(NSString *str){
        [self setTitle:str forState:UIControlStateDisabled];
        return self;
    };
}

////titleColor
-(void)setSt_disabledTitleColor:(UIButton *(^)(UIColor *))st_disabledTitleColor{}
-(UIButton *(^)(UIColor *))st_disabledTitleColor{
    return ^(UIColor *color){
        [self setTitleColor:color forState:UIControlStateDisabled];
        return self;
    };
}

////backgroudImage
-(void)setSt_disabledBackgroundImage:(UIButton *(^)(NSString *))st_disabledBackgroundImage{}
-(UIButton *(^)(NSString *))st_disabledBackgroundImage{
    return ^(NSString *str ){
        [self setBackgroundImage:[UIImage imageNamed:str] forState:UIControlStateDisabled];
        return self;
    };
}

#pragma mark textAlignment 及 frame
-(void)setSt_textAlignment:(UIButton *(^)(NSTextAlignment))st_textAlignment{};

-(UIButton *(^)(NSTextAlignment))st_textAlignment{
    return ^(NSTextAlignment textAlignment){
        
        self.titleLabel.textAlignment = textAlignment;
        return self;
    };
    
}


-(void)setSt_frame:(UIButton *(^)(CGRect))st_frame{}

-(UIButton *(^)(CGRect))st_frame{
    return ^(CGRect rect){
        self.frame = rect;
        return self;
    };
}

-(void)setSt_font:(UIButton *(^)(CGFloat))st_font{}
-(UIButton *(^)(CGFloat))st_font{
    return ^(CGFloat size){
        self.titleLabel.font = [UIFont systemFontOfSize:size];
        return self;
    };
}

@end

@implementation UILabel (Extension)
#pragma mark  label.text
-(void)setSt_title:(UILabel *(^)(NSString *))st_title{}

-(UILabel *(^)(NSString *))st_title{
    return ^(NSString *str){
        self.text =str;
        return self;
    };
}

#pragma mark label.backgroundColor
-(void)setSt_backgroundColor:(UILabel *(^)(UIColor *))set_backgroundColor{}

-(UILabel *(^)(UIColor *))st_backgroundColor{
    
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

#pragma mark label.textAlignment
-(void)setSt_textAlignment:(UILabel *(^)(NSTextAlignment))st_textAlignment{};

-(UILabel *(^)(NSTextAlignment))st_textAlignment{
    return ^(NSTextAlignment textAlignment){
        self.textAlignment = textAlignment;
        return self;
    };
    
}

#pragma mark label.frame
-(void)setSt_frame:(UILabel *(^)(CGRect))st_frame{}

-(UILabel *(^)(CGRect))st_frame{
    return ^(CGRect rect){
        self.frame = rect;
        return self;
    };
}

#pragma mark label.font
-(void)setSt_font:(UILabel *(^)(CGFloat))st_font{}
-(UILabel *(^)(CGFloat))st_font{
    return ^(CGFloat size){
        self.font = [UIFont systemFontOfSize:size];
        return self;
    };
    
}
#pragma mark label.textColor
-(void)setSt_textColor:(UILabel *(^)(UIColor *))st_textColor{}
-(UILabel *(^)(UIColor *))st_textColor{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}
@end

@implementation UIImageView (Extension)
-(void)setSt_frame:(UIImageView *(^)(CGRect))st_frame{}

-(UIImageView *(^)(CGRect))st_frame{
    return ^(CGRect rect){
        self.frame = rect;
        return self;
    };
}
-(void)setSt_backgroundColor:(UIImageView *(^)(UIColor *))set_backgroundColor{}

-(UIImageView *(^)(UIColor *))st_backgroundColor{
    return ^(UIColor *color){
        self.backgroundColor = color;
        return self;
    };
}

-(void)setSt_image:(UIImageView *(^)(NSString *))st_image{}
-(UIImageView *(^)(NSString *))st_image{
    return ^(NSString *str){
        self.image = [UIImage imageNamed:str];
        return self;
    };
    
}
@end

