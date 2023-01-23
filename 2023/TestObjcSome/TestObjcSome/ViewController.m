//
//  ViewController.m
//  TestObjcSome
//
//  Created by Augus on 2023/1/13.
//

#import "ViewController.h"
#import "GTPerson.h"
#import <objc/runtime.h>
#import "GTPerson+Test.h"

@interface ViewController ()

@property (nonatomic, strong) GTPerson *person1;
@property (nonatomic, strong) GTPerson *person2;


@end

@implementation ViewController


struct gt_objc_class {
    Class isa;
};

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // 分类间接添加属性
//    GTPerson *person = [[GTPerson alloc] init];
//    person.name = @"augus";
//    NSLog(@"person name is %@",person.name);
    
    
    
    
    
//    self.person1 = [[GTPerson alloc] init];
//
//    // 强制转换类型
//    Class personCls = [GTPerson class];
//    struct gt_objc_class *personCls1 = (__bridge struct gt_objc_class *)(personCls);
//
//
//    Class person1MetaCls = object_getClass(personCls);
//
//
//    self.person2 = [[GTPerson alloc] init];
    
    // 查看kvo监听前后类对象的改变
//    NSLog(@"kvo监听之前 %@ %@",object_getClass(self.person1) , object_getClass(self.person1));
    
    // 查看kvo监听之后的方法的改变
//    NSLog(@"kvo监听之前 %p %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
    
//    [self.person1 addObserver:self forKeyPath:@"age" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:nil];
    
//    NSLog(@"kvo监听之后 %@ %@",object_getClass(self.person1) , object_getClass(self.person1));
//    NSLog(@"kvo监听之后 %p %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
    
    
//    [self printMethodNameOfClass:object_getClass(self.person1)];
    
    
    
    

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self.person1 setAge:18];
//    [self.person2 setAge:19];
//
//
//    [self.person1 willChangeValueForKey:@"age"];
//    [self.person1 didChangeValueForKey:@"age"];
    
//    self.person1->_age = 12;
    
    
    // 1的位置上strong，这个时候执行1之后，发现是强引用，会立即释放
    // 1的位置是weak，这个时候执行1之后，不会立即释放，因为发现还有强引用，所以大概等待3秒之后才会释放
    
    GTPerson *person = [[GTPerson alloc] init];
    
    __weak GTPerson *weakPerson = person;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSLog(@"1---p is %p",person);

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"2---p is %p",weakPerson);

        });
    });
    
    NSLog(@"%@",@(__func__));
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"kvo 监听响应 %@",change);
}


#pragma mark - Private Methods

- (void)printMethodNameOfClass:(Class)cls {
    
    unsigned int count;
    
    NSMutableString *methodNames = [NSMutableString string];
    
    // 获取方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    
    // 遍历方法数组
    for (int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL sel =  method_getName(method);
        NSString *methodName = NSStringFromSelector(sel);
        [methodNames appendFormat:@"%@\n",methodName];
        
    }
    
    NSLog(@"%@类包含的所有方法\n%@",cls,methodNames);
    
    // c语言手动管理内存
    free(methodList);
    
    
}


@end
