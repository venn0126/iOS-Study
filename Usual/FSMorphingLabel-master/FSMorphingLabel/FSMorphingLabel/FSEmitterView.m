//
//  FSEmitterView.m
//  iDraw
//
//  Created by 翁志方 on 2016/12/30.
//  Copyright © 2016年 翁志方. All rights reserved.
//

#import "FSEmitterView.h"

@implementation FSEmitter

- (instancetype)initWithName:(NSString *)name
                 paticleName:(NSString *)particleName
                    duration:(float)duration
{
    if (self = [super init]) {
        self.cell.name = name;
        UIImage *img = [UIImage imageNamed:particleName];
        self.cell.contents = (__bridge id) img.CGImage;     // 不能直接写成 img！
        
        self.duration = duration;
    }
    return self;
}
- (CAEmitterLayer *)layer
{
    if (_layer == nil){
        _layer = [[CAEmitterLayer alloc] init];
    }
    return _layer;
}
- (CAEmitterCell *)cell
{
    if (_cell == nil){
        _cell = [[CAEmitterCell alloc] init];
    }
    return _cell;
}

- (void)play
{
    if (self.layer.emitterCells.count > 0) {
        return ;
    }
    self.layer.emitterCells = @[self.cell];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.layer.birthRate = 0;
    });
}

- (void)stop
{
    if (self.layer.superlayer) {
        [self.layer removeFromSuperlayer];
    }
}

- (FSEmitter *)update:(FSEmitterConfigureClosure) closure
{
    closure(self.layer, self.cell);
    return self;
}

@end


@implementation FSEmitterView

- (NSMutableDictionary *)emitters
{
    if (_emitters == nil) {
        _emitters = [NSMutableDictionary dictionary];
    }
    return _emitters;
}

- (FSEmitter *)createEmitter:(NSString *)name
                particleName:(NSString *)particleName
                    duration:(float)duration
            configureClosure:(FSEmitterConfigureClosure) closure
{
    FSEmitter *emitter = [self emitterByName:name];
    if (emitter == nil) {
        emitter = [[FSEmitter alloc] initWithName:name
                                      paticleName:particleName
                                         duration:duration];
        
        closure(emitter.layer, emitter.cell);
        [self.layer addSublayer:emitter.layer];
        [self.emitters setObject:emitter forKey:name];
    }
    return emitter;
}

- (FSEmitter *)emitterByName:(NSString *)name
{
    return self.emitters[name];
}

- (void)removeAllEmitters
{
    for (FSEmitter *emitter in self.emitters.allValues) {
        [emitter.layer removeFromSuperlayer];
    }
    [self.emitters removeAllObjects];
    
}


@end









