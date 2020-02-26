//
//  Part1.m
//  JRTT
//
//  Created by Augus on 2020/1/14.
//  Copyright © 2020 fosafer. All rights reserved.
//

#import "Part1.h"


@interface Part1()

@property (nonatomic, copy) NSString *sex;


@end
//@synthesize foo = myFoo;



@implementation Part1{
    
    NSString *_sex;
}

//@synthesize sex = _sex;

- (instancetype)init {
    
    if (self = [super init]) {
        _sex = @"man";
    }
    return self;
}

/// setter

- (void)setSex:(NSString *)sex {

    _sex = sex;
}


/// getter

- (NSString *)sex {
    return _sex;
}

- (void)VENNInit {
    
    
    NSLog(@"---VENNInit---");
}

/*
 
 
 iOS 布局原理及种类
 
 内存泄漏
 
 
 
 1 Login 名词
   LogIn 动词
 
    enum枚举应该使用，typedef NS_ENUM {};
   原因：不仅能为枚举值指定类型，而且当赋值赋错类型时，编译器还会给出警告
 
   size_t s1 = sizeof(int);
   size_t s2 = sizeof(long);
   size_t s3 = sizeof(float);
   size_t s4 = sizeof(double);
 
   32位机器结果：4 4 4 8
   64位机器结果：4 8 4 8
 
   int -> NSInteger
   unsigned -> NSUInteger
   float -> CGFloat
   动画时间 -> NSTimeInterval
 
   在集合内元素不多时，经典for循环的效率要比forin要高，但是从代码可读性上来看，就远不如forin看着更顺畅；
 
   使用"and"来表示两个相对独立的操作，注意命名规范，这样会使得代码易读
 
   属性的参数应该按照下面的顺序排列： 原子性，读写 和 内存管理。这样做你的属性更容易修改正确，并且更好阅读
 
  2 什么情况使用weak关键字，相比assign有什么不同？
    >在ARC中有可能回出现运行循环引用的时候，往往需要让其中的一端，使用weak来解决，比如delegate属性
    >自身已经对它强引用一次了，没有必要再引用一次，此时也会用IBOutlet控件属性，一般也是用weak，当然strong也ok
 
不同点：weak此特质表明了该属性定义了一种非拥有关系，为这种属性设置新的值的时候，设置方法既不保留新的值，也不释放旧的值，此特质与assign类似，然后在属性所指的对象遭到摧毁的时候，属性值也会清空，而assign的设置方法只会执行针对纯量类型比如CGFloat或NSInterger的简单操作
 assign可用于非oc对象，而weak必须用于oc对象
 
 
 3 如何用copy关键字
 
   NSStrig NSArray NSDictionary等经常使用copy关键字是因为他们有对应的可变类型，NSMutableString，NSMutableArray，NSDictionary
 
   Block也经常使用copy关键字，
 
   block在mrc的时代，内部方法的block是在栈区的，使用copy可以把它放到堆区，
   在arc中，写不写都可以，对于block使用strong和copy效果是一样的
 
   
 4 @property (copy) NSMutableArray *array;
   这样写会有什么后果
 
  >添加，删除，修改数组元素的时候会因为找不到对应的反法而崩溃，因为copy是复制一个不可变的NSArray对象，
   声明一个copy特质的可变对象，然后进行一个可变对象的赋值操作，然后就会崩溃
   -[__NSArrayI removeAllObjects]: unrecognized selector sent to instance 0x600000dbffc0
 
    
 
  >使用atomic会严重影响性能，
   该属性使用了自选锁，会在创建时生成一些额外的代码用于帮助编写多线程，这会带来性能问题，通过声明nonatomic可以节省这些
   虽然很小，但是不必要额外开销
  在iOS开发中你会发现，所有的属性声明几乎都是nonatomic，一般情况下并不要求属性必须是原子的，因为并不能保证线程安全，若要实现安全线程的操作，需要实现更为深层的锁定机制才行，例如：一个线程在连续多次读取某属性值的操作过程中有别的线程同时在改写该值，那么即便将该属性声明为atomic，还是会读取到不同的值
 
 
 5 如何让自己的类用copy修饰符，如何重写带copy关键字的setter？
 
   实现NSCoping协议，该协议只有一个方法，
 -（id） copyWithZone:(NSZone *)zone;
    
 
 6 property本质是什么？ivar getter setter是如何生成并添加到这个类中的
 
   @property的本质是什么？
 
    @property = ivar（实例变量） +（存取方法） getter + setter
 
   下面解释下：
    属性作为OC的一个特性，主要的作用在于封装对象中的数据，OC对象通常会把其所需要的数据保存为各种实例变量，实例变量一般通过存取方法来访问
 其中getter用于读取变量值，而设置方法用于写入变量值，
 完成属性定义后，编译器就会自动编写访问这些属性的方法，此过程叫自动合成，需要强调的是，这个过程由编译器在编译期自动执行，所以编辑器看不到这些合成方法，出了生成方法代码getter，setter之外，编译器还要自动向类中添加适当类型的实例，并且在属性名前面加下划线，以此作为实例变量的名字，为了搞清楚属性怎么实现的，我曾经反编译过他们的相关代码，大概生成了5个东西
 
  >OBJC_IVAR_$类名_$属性名：该属性偏移量，这个偏移量是硬编码，表示该变量距离存放内存区域的地址有多远
  >setter&getter方法对应的实现函数
  >ivar_list:成员变量列表
  >method_list：方法列表
  >prop_list:属性列表
 
 也就是说我们没次增加一个属性，系统都会在ivar_list中添加一个成员变量的描述，method_list中增加，setter与getter方法的描述，在属性列表中增加一个属性的描述，然后计算该属性在对象中的偏移量，然后给出setter与getter方法对应的实现，在setter方法中从偏移量开始赋值，在getter方法中从偏移量开始取值，为了能够正确字节数，系统对象对偏移量的指针类型进行了类型强转
 
 
 7 @protocol 和category中如何使用@property
 
    >在protocol中使用property只会生成setter和getter方法的声明，我们使用属性的目的，是希望遵守我协议的对象能实现该属性
    >category使用@property也只会生成setter和getter方法的声明，如果我们真的需要给category增加属性的实现，需要借助于两个函数
 
    　objc_setAssociateObject
      objc_getAssociateObject
 
 
 8 runtime 如何实现weak变量的自动置nil
runtime对注册的类，会进行布局，对与weak对象会放入一个hash表中，用weak指向的对象内存地址作为key，当对象的引用引用计数为0的时候就会被dealloc，假如weak指向的对象内存地址为a，那么就以a为健，在这个weak表中进行搜索，找到所有以a为建的weak对象，从而设置为nil
 
  
 9.@property  有哪些属性关键字，@property后面有哪些修饰符
   属性可以拥有的特质分为四类
   >原子性，----nonatomic，特质
   >读/写权限----readwrite，readonly
   >内存管理语义---assgin，strong，weak，unsafe——unretained，copy
   >方法名，----getter=<name>，setter=<name>
    

  10 weak属性需要在dealloc中置为nil么？
 
     不需要
     原因：ARC帮我们自动处理
 
 
 11 @synthesize（合成）和@dynamic（动态）分别有什么作用？
 
    @synthesize语义是如果你没有手动实现setter方法和getter方法，那么编译器会自动帮你加上这两个方法
    @dynamic语义是属性的setter和getter是由用户自己实现的，不自动生成，当然对于readonly只需要手动实现getter方法，假如一个属性被声明为@dynamic var，然后你没有提供setter方法和getter方法，编译的时候没有问题，但是运行到instance.var = one,someVar = var时候，会因为找不到相应的方法而崩溃，编译时没有问题，运行时才执行相应的方法，这就是所谓的动态绑定
 
 12 ARC下，不显式指定任何属性关键字时，默认的关键字有哪些？
 
    1 基本数据类型：atomic，readwrite，assgin
    2 普通的oc对象，atomic，readwrite，strong
 
 13 用@property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？
 
  原因：因为父类指针可以指向子类对象，使用copy的目的就是为了让对象的属性不受外界影响，使用copy无论传给我的是一个可变对象还是不可变对象，我本身就是持有一个不可变的副本
 
        如果我们使用的是strong，那么属性的就有可能指向一个可变对象，如果这个可变对象在外部被修改了，那么会影响该属性
 
 
    内容拷贝===深拷贝，指针拷贝===浅拷贝
    对非集合类对象copy和mutableCopy操作(NSString)

    immutableObject copy   浅复制
    immutableObject mutablecopy 深复制
    mutableObject copy 深复制
    mutableObject mutablecopy 深复制
 
 
    对集合类对象copy和mutableCopy操作(NSArray)
 
    
 
     NSArray *array = @[@[@"a", @"b"], @[@"c", @"d"]];
     NSArray *copyArray = [array copy];
     NSMutableArray *mCopyArray = [array mutableCopy];
 
    array和copyArray的内存地址是一样的，array与mCopyArray的地址是不同的，
    说明copy进行了指针拷贝，mutableCopy进行了内容拷贝，
 
     immutableObject copy   浅复制
     immutableObject mutablecopy 单层深复制
     mutableObject copy 单层深复制
     mutableObject mutablecopy 单层深复制
 
 
 14  @synthesize合成实例变量的规则是什么？假如property名为foo，存在一个名为_foo的实例变量，那么还会自动合成新变量么？
 
    实例变量====成员变量====ivar
 
    总结下 @synthesize 合成实例变量的规则，有以下几点：
 
    >如果指定了成员变量的名称，那么会生成一个指定的名称的成员变量
    >如果这个成员已经存在了，就不再生成了
    >如果是@synthesize foo，还会生成一个foo名称的变量，也就是说如果没有指定成员变量的名称会自动生成一个属性同名的成员变量
     如果是@synthesize foo = myFoo，就不会自动生成了
 
 
 15 在有了自动合成属性实例变量之后，@synthesize还有哪些使用场景？
 
   什么情况下不会自动合成，autosynthesize？
   >同时重写了setter和getter时
   >重写了只读属性getter时
   >使用了@dynamic
   >在protocol定义的属性
   >在category中定义的属性
   >重载的属性
 
 
   当你手动重写了setter和getter的时候，你需要去关联property和ivarm，要么手动创建ivar，要么使用@synthesize去进行合成
 
 16 objc中向一个nil对象发送消息将会发生什么？
 
    在oc中向nil 发送消息是完全有效的，只是不会有任何作用
 
    Person * motherInlaw = [[aPerson spouse] mother];
    如果spouse对象为nil，发送给nil的消息也将返回给nil，如果方法返回值为指针类型，其指针类型大小为小于或者等于sizeof（void *），float double，long double，或者long long，的整型标量发给nil消息将返回0，
    如果方法返回值为结构体，发送给nil的消息将返回0，结构体中各个字段的值都将是0，
    如果方法的返回值不是上述提到的几种情况那么发给nil的消息的返回值将是为定义的
 
    objc是动态语言，每个方法在运行时会被动态转为消息发送，即objc——msgSend（objc，selector）
 

 objc在向一个对象发送信息时，runtime仓库根据对象的isa指针找到该对象实际所属的类，然后在该类中的方法列表以及其父类方法列表中寻找方法运行，然后在发送消息的时候，objc_msgSend方法不会返回值，所谓的返回内容都是具体调用时执行的，那么回到本题，如果向一个nil对象发送消息，首先在寻找对象的isa指针时就是0地址返回了，所以不会出现任何错误
 
 
 17 objc中向一个对象发送消息 [obj foo]  objc_msgSend（）函数之间的关系
    具体原因：该方法编译之后就是objc_msgSend()函数调用
 
    Part1 *p = [[Part1 alloc] init];
    [p performSelector:@selector(VENNInit)];
    
    Part1 *p = ((Part1 *(*)(id, SEL))(void *)objc_msgSend)((id)((Part1 *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("Part1"), sel_registerName("alloc")), sel_registerName("init"));
        
    ((id (*)(id, SEL, SEL))(void *)objc_msgSend)((id)p, sel_registerName("performSelector:"), sel_registerName("VENNInit"));
        
 
    也就是说[p VENNInit]编译时就会被转化成objc_msgSend(obj,@selector(VENNInit))
 
 18 什么时候会报unrecognized selector的异常
    简单来说，当调用该对象上的没有实现这个方法的时候，可以通过消息转发进行解决
    简单的流程如下，在上一题中也提到过，
    objc时动态语言，每个方法在运行时会被动态转为消息发送，即objc_msgSend(objc,@selector(VENNInit))
    
    objc在向一个对象发送消息时，runtime库根据对象isa指针找到该对象实际所属的类，然后在该类中方法列表以及其父类方法中寻找方法运行，如果在最顶层的父类中依然找不到相应的方法时，程序在运行时会挂掉并抛出异常unrecongnized selector sent to XXX，但是在这之前，objc 的运行时会给出三次拯救程序的机会
 
 
   > methond resolution
      objc 运行时会调用，resolveInstanceMethond 或者 resolveClassMethod，让你有机会提供一个函数实现，如果你添加了函数，那运行时系统会重新启动一次消息发送的过程，否则，运行时就会移到下一步，消息转发（Message Forwarding）
  
   >Fast forwarding
    如果目标对象实现了-forwardingTargetForSelector：，Runtime这时就会调用这个方法，给你把这个消息转发其他对象的机会，只要方法返回的不是nil和self，整个消息发送的过程就会被重启，当然发送的对象会变成你返回的那个对象。否则就会继续Normal Forwarding
 
 
 
   > 这一步是runtime最后一次挽救的机会，首先它会发送-methodSignatureSelector：消息获得参数的参数值和返回值类型，如果-methodSignatureSelector：返回nil，runtime则会发出-doesnotRecongnizeSelector：消息，程序这时候就挂掉了，如果返回一个函数签名，runtime就会创建一个NSInvocation对象并发送-forwardInvocation：消息给目标对象
 
 
 
 19 一个objc对象如何布局
 
  所有父类的成员变量和自己的成员变量都会存放在该对象对应的存储空间中
  每个对象内部都有一个isa指针，指向他的父类对象，类对象存放着本对象的
 
    >对象方法列表
    >成员变量列表
    >属性列表
  它内部也有一个isa指针指向元对象（meta class），元对象内部存放的是类方法列表，类对象内部还有一个superclass的指针，
  指向他的父类对象
 
 一个objc对象的isa指针有什么作用？
 指向他的类对象，从而找到对象上的方法
 
 20 下面输出什么
 
 @implementation Son : Father
 - (id)init
 {
     self = [super init];
     if (self) {
         NSLog(@"%@", NSStringFromClass([self class]));
         NSLog(@"%@", NSStringFromClass([super class]));
     }
     return self;
 }
 @end
 
 self：类的隐藏函数，指向当前调用方法的这个类的实例，
 super：编译器的标识符，指向同一个消息接受者，
 不同点在于：super会告诉编译器，调用class方法的时候，要去父类方法，而不是本类里的
 流程：当调用[self class]的时候实际上调用的是objc_msgSend函数，第一个参数是Son的当前的实例，然后在Son这个类里面去找，-（Class）class方法，没有去Father里面去找，也没有，最后在NSObject里面找到，而（Class）class的实现就是返回self的类别，所以输出为son
 
 而当调用[super class]的时候，会转换成objc_msgSendSuper函数，第一步先构造objc_super结构体，结构体的第一个成员就是self，第二个就是（id）class——getSuperClass（objc_getClass（”Son“）），实际该输出结果为Father，第二步是去Father里面找-（Class）class没有，又去NSObjectm里面去找找到了，最后内部使用的是objc_msgSend（objc_super->receiver，@selector（class））去调用
 此时和self class调用相同，所以上述输出也是Son
 
 21 runtime如何通过selector找到对应的IMP地址？（分别考虑类方法和实例方法）
 
 每一个类对象中都有一个方法列表，方法列表记录着方法的名称，方法实现，以及参数类型，其实selector本质就是方法名称，通过这个方法名称就可以在方法列表中找到方法的实现
 
 22 使用runtime Associate方法关联的对象，需要在主对象dealloc的时候释放么？
 
 不需要
 
 // 对象的内存销毁时间表
 // 根据 WWDC 2011, Session 322 (36分22秒)中发布的内存销毁时间表

  1. 调用 -release ：引用计数变为零
      * 对象正在被销毁，生命周期即将结束.
      * 不能再有新的 __weak 弱引用， 否则将指向 nil.
      * 调用 [self dealloc]
  2. 子类 调用 -dealloc
      * 继承关系中最底层的子类 在调用 -dealloc
      * 如果是 MRC 代码 则会手动释放实例变量们（iVars）
      * 继承关系中每一层的父类 都在调用 -dealloc
  3. NSObject 调 -dealloc
      * 只做一件事：调用 Objective-C runtime 中的 object_dispose() 方法
  4. 调用 object_dispose()
      * 为 C++ 的实例变量们（iVars）调用 destructors
      * 为 ARC 状态下的 实例变量们（iVars） 调用 -release
      * 解除所有使用 runtime Associate方法关联的对象
      * 解除所有 __weak 引用
      * 调用 free()
 
 
 -----------------------------------------
    
 23 _objc_msgForward函数做什么的？直接调用会发生
 
 _objc_msgForward是IMP类型，用于消息转发，当一个对象发送一条消息，但它并没有实现的时候，
 _objc_msgForward尝试做消息转发
 
 
 24  runtime如何实现weak变量的自动置nil？
     runtime对注册的类，会进行布局，对于weak对象会放入一个 hash 表中。 用 weak 指向的对象内存地址作为 key，当此对象的引用计数为0的时候会 dealloc，假如 weak 指向的对象内存地址是a，那么就会以a为键， 在这个 weak 表中搜索，找到所有以a为键的 weak 对象，从而设置为 nil。
 
 25 布局
 
    手写UI：灵活自由，需要编写大量代码，
    AutoresizingMasks，在 UIVie中有一个autoresizingMask的属性，它对应的是一个枚举的值，属性的意思就是自动调整子控件与父控件中间的位置，宽高。默认值是UIViewAutoresizingNone，控件不会随父视图的改变而改变。
 
    Frame：当前视图在其父视图中的位置和大小。在初始化 view 的时候，可以设置 view 的frame
    bounds：提到 frame 不得不提 bounds，bounds指的是前视图在其自身坐标系统中的位置和大小。可以看到两者的区别在于坐标系不同。


    xib，不需要手写代码，管理复杂
    sb：为了替换xib，iOS5之后推出的，统一管理xib，多人协作容易产生冲突
 
     
    
 
 26 内存泄漏场景
    CF类型内存
 
    NSTimer 循环引用
    NSNotification 循环引用
    block  循环引用，使用
 
 
 
 
    
 
 */


@end
