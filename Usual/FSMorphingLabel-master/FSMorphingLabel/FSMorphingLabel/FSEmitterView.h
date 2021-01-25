//
//  FSEmitterView.h
//  iDraw
//
//  Created by 翁志方 on 2016/12/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FSEmitterConfigureClosure)(CAEmitterLayer *layer, CAEmitterCell *cell);


@interface FSEmitter : NSObject

@property (nonatomic, strong) CAEmitterLayer *layer;

@property (nonatomic, strong) CAEmitterCell *cell;

@property (nonatomic, assign) float duration;


- (instancetype)initWithName:(NSString *)name
                 paticleName:(NSString *)paticleName
                    duration:(float)duration;

- (void)play;

- (void)stop;

- (FSEmitter *)update:(FSEmitterConfigureClosure) closure;


@end


@interface FSEmitterView : UIView

@property (nonatomic, strong) NSMutableDictionary *emitters;

- (FSEmitter *)createEmitter:(NSString *)name
                particleName:(NSString *)particleName
                    duration:(float)duration
            configureClosure:(FSEmitterConfigureClosure) closure;


- (FSEmitter *)emitterByName:(NSString *)name;

- (void)removeAllEmitters;


@end
