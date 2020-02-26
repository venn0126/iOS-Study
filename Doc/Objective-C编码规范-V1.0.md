# 代码格式

- 使用空格而不是使用制表符Tab

> 缩进使用4个空格，不要使用 tab, 确保你在 Xcode 的设置里面是这样设置的
> 方法的大括号和其他的大括号(if/else/switch/while 等) 总是在同一行开始，在新起一行结束
> 括号的换行,我们推荐Apple官方的推荐方式

**推荐：**

```
if (user.isHappy) {
    //Do something
}
else {
    //Do something else
}
```

**不推荐：**

```
if (user.isHappy)
{
  //Do something
} else {
  //Do something else
}
```
- 函数调用

应该总是让冒号对齐。有一些方法签名可能超过三个冒号，用冒号对齐可以让代码更具有可读性。即使有代码块存在，也应该用冒号对齐方法

**推荐：**

```objectivec
[UIView animateWithDuration:1.0
                 animations:^{
                     // something
                 }
                 completion:^(BOOL finished) {
                     // something
                 }];
```

**不推荐：**

```objectivec
[UIView animateWithDuration:1.0 animations:^{
    // something
} completion:^(BOOL finished) {
    // something
}];
```

# 代码组织

**Pragma Mark -**

`#pragma mark -`是一个在类内部组织代码并且帮助你分组方法，我们建议使用 #pragma mark - 来做方法分组

```objectivec
#pragma mark - lifeCycle （View 的生命周期）

- (void)viewDidLoad { /* ... */ }
- (void)viewWillAppear:(BOOL)animated { /* ... */ }
- (void)didReceiveMemoryWarning { /* ... */ }

#pragma mark - private methods (私有函数)

- (void)setCustomProperty:(id)value { /* ... */ }
- (id)customProperty { /* ... */ }

#pragma mark - event response (响应事件)  

- (IBAction)submitData:(id)sender { /* ... */ }

#pragma mark - public methods (公开函数)

- (void)publicMethod { /* ... */ }

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { /* ... */ }

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;         

#pragma mark - getter\setter 

- (NSArray *)name {
    if (!_name) {
        _name = [[NSArray alloc] init];
    }
    return _name;
}

- (void)setName:(NSArray *)name {
    _name = name;
}
```

# 命名规范

- 通用的约定

推荐使用具有清晰描述性的方法名或变量名

**推荐：**

```objectivec
UIButton *settingsButton;
```

**不推荐：**

```objectivec
UIButton *setBut;
```

- 常量

常量应该以驼峰法命名，并以相关类名作为前缀，这里如果感觉类名文字太长，我们也可以约定以类名的缩写作为前缀

**推荐：**

```objectivec
static const NSTimeInterval ZOCSignInViewControllerFadeOutAnimationDuration = 0.4;
```

**不推荐：**

```objectivec
static const NSTimeInterval fadeOutTime = 0.4;
```

推荐使用常量来代替字符串字面值和数字，这样能够方便复用，而且可以快速修改而不需要查找和替换。常量应该用 static 声明为静态常量，而不要用 #define，除非它明确的作为一个宏来使用

**推荐：**

```objectivec
static NSString * const ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";
static const CGFloat ZOCImageThumbnailHeight = 50.0f;
```

**不推荐：**

```cpp
#define CompanyName @"Apple Inc."
#define magicNumber 42
```

常量应该在头文件中以这样的形式暴露给外部：

```objectivec
extern NSString *const ZOCCacheControllerDidClearCacheNotification;
```

并在实现文件中为它赋值

```objectivec
NSString * ZOCCacheControllerDidClearCacheNotification = @"ZOCCacheControllerDidClearCacheNotification";
```

- 方法

方法名与方法类型 (-/+)之间应该以空格间隔。方法段之间也应该以空格间隔（以符合 Apple 风格）。参数前应该总是有一个描述性的关键词。

尽可能少用 "and"，它不应该用来阐明有多个参数，比如下面的 initWithWidth:height: 这个例子：

**推荐：**

```objectivec
- (void)setExampleText:(NSString *)text image:(UIImage *)image;
- (void)sendAction:(SEL)aSelector to:(id)anObject forAllCells:(BOOL)flag;
- (id)viewWithTag:(NSInteger)tag;
- (instancetype)initWithWidth:(CGFloat)width height:(CGFloat)height;
```

**不推荐：**

```objectivec
- (void)setT:(NSString *)text i:(UIImage *)image;
- (void)sendAction:(SEL)aSelector :(id)anObject :(BOOL)flag;
- (id)taggedView:(NSInteger)tag;
- (instancetype)initWithWidth:(CGFloat)width andHeight:(CGFloat)height;
- (instancetype)initWith:(int)width and:(int)height;  // Never do this.
```

- 字面量

推荐使用字面值来创建不可变的 NSString, NSDictionary, NSArray, 和 NSNumber 对象。注意不要将 nil 传进 NSArray 和 NSDictionary里，因为这样会导致崩溃

**推荐：**

```objectivec
NSArray *names = @[@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul"];
NSDictionary *productManagers = @{@"iPhone" : @"Kate", @"iPad" : @"Kamal", @"Mobile Web" : @"Bill"};
NSNumber *shouldUseLiterals = @YES;
NSNumber *buildingZIPCode = @10018;
```

**不推荐：**

```objectivec
NSArray *names = [NSArray arrayWithObjects:@"Brian", @"Matt", @"Chris", @"Alex", @"Steve", @"Paul", nil];
NSDictionary *productManagers = [NSDictionary dictionaryWithObjectsAndKeys: @"Kate", @"iPhone", @"Kamal", @"iPad", @"Bill", @"Mobile Web", nil];
NSNumber *shouldUseLiterals = [NSNumber numberWithBool:YES];
NSNumber *buildingZIPCode = [NSNumber numberWithInteger:10018];
```

如果要用到这些类的可变副本

**推荐：**

```objectivec
NSMutableArray *aMutableArray = [NSMutableArray array];
```

**不推荐：**

```objectivec
NSMutableArray *aMutableArray = [@[] mutableCopy];
```

# 类

- 类名

每一个类文件名称，我们按照规范加上前缀，默认是以公司缩写作为前缀: `WLxxx`

- 初始化

**推荐：**

```objectivec
- (instancetype)init {
    self = [super init]; // call the designated initializer
    if (self) {
        // Custom initialization
    }
    return self;
}
```

**不推荐：**

```objectivec
- (instancetype)init {
    if ([super init]) {
        // Custom initialization
    }
    return self;
}
```

- 属性

*属性变量*

**推荐：**

```objectivec
NSString *text;
```

**不推荐：**

```objectivec
NSString* text;
NSString * text;
```

*点符号*

当使用 setter getter 方法的时候尽量使用点符号。应该总是用点符号来访问以及设置属性。

**推荐：**

```csharp
view.backgroundColor = [UIColor orangeColor];
[UIApplication sharedApplication].delegate;
```

**不推荐：**

```css
[view setBackgroundColor:[UIColor orangeColor]];
UIApplication.sharedApplication.delegate;
```

*属性定义*

推荐按照下面的格式来定义属性

**推荐：**

```objectivec
@property (nonatomic, readwrite, copy) NSString *name;
```

**不推荐：**

```objectivec
@property (nonatomic, copy, readwrite) NSString *name;
```

属性的参数应该按照下面的顺序排列：原子性，读写 和 内存管理。这样做你的属性更容易修改正确，并且更好阅读。(译者注：习惯上修改某个属性的修饰符时，一般从属性名从右向左搜索需要修动的修饰符。最可能从最右边开始修改这些属性的修饰符，根据经验这些修饰符被修改的可能性从高到底应为：内存管理 > 读写权限 >原子操作)

为了完成一个公有的 getter 和一个私有的 setter，应该声明公开的属性为 readonly，并且在类扩展中重新定义通用的属性为 readwrite

```objectivec
//.h文件中
@interface MyClass : NSObject
@property (nonatomic, readonly, strong) NSObject *object;
@end

//.m文件中
@interface MyClass ()
@property (nonatomic, readwrite, strong) NSObject *object;
@end

@implementation MyClass
//Do Something cool
@end
```

描述BOOL属性的词如果是形容词，那么setter不应该带is前缀，但它对应的 getter 访问器应该带上这个前缀

**示例：**

```objectivec
@property (assign, getter=isEditable) BOOL editable;
```

*私有属性*

私有属性应该定义在类的实现文件中，不应该定义在申明文件中

```objectivec
.m文件
@interface ZOCViewController ()
@property (nonatomic, strong) UIView *bannerView;
@end
```

*懒加载*

实例化一个对象需要耗费很多资源，或者配置一次就要调用很多配置相关的方法而你又不想弄乱这些方法时，我们需要重写 getter 方法以延迟实例化，而不是在 init 方法里给对象分配内存

**推荐：**

```objectivec
- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = [[NSArray alloc] init];
    }
    return _nameArray;
}
```

# 条件语句

> 条件语句体应该总是被大括号包围，尽管有时候你可以不使用大括号（比如，条件语句体只有一行内容），但是这样做会带来问题隐患。比如，增加一行代码时，你可能会误以为它是 if 语句体里面的。此外，更危险的是，如果把 if 后面的那行代码注释掉，之后的一行代码会成为 if 语句里的代码

- if

**推荐：**

```bash
if (!error) {
    return success;
}
```

**不推荐：**

```bash
if (!error)
    return success;
 
if (!error) return success;
```

- 三目运算符

**推荐：**

```undefined
result = a > b ? x : y;
```

**不推荐：**

```undefined
result = a > b ? x = c > d ? c : d : y;
```

# Case语句

> 括号在 case 语句里面是不必要的，但是当一个 case 包含了多行语句的时候，需要加上括号

**示例：**

```cpp
switch (condition) {
    case 1:
        // ...
        break;
    case 2: {
        // ...
        // Multi-line example using braces
        break;
       }
    case 3:
        // ...
        break;
    default:
        // ...
        break;
}
```

> 当两个条件语句执行的是同一个代码块时，我们可以合并条件语句

**示例：**

```cpp
switch (condition) {
    case 1:
    case 2:
        // code executed for values 1 and 2
        break;
    default:
        // ...
        break;
}
```

> 当在 switch 语句里面使用一个可枚举的变量作为判断条件时，default我们可以省略掉

**示例：**

```cpp
switch (menuType) {
    case ZOCEnumNone:
        // ...
        break;
    case ZOCEnumValue1:
        // ...
        break;
    case ZOCEnumValue2:
        // ...
        break;
}
```

- 枚举类型

> 当使用 enum 的时候，建议使用`NS_ENUM()`定义，因为它有更强大的类型检查和代码补全功能

```objectivec
typedef NS_ENUM(NSUInteger, ZOCMachineState) {
    ZOCMachineStateNone,
    ZOCMachineStateIdle,
    ZOCMachineStateRunning,
    ZOCMachineStatePaused
};
```

# 分类

> 推荐在 category 方法前加上自己的小写前缀以及下划线，比如- (id)zoc_myCategoryMethod，这种实践同样被苹果推荐

这是非常必要的。因为如果在扩展的 category 或者其他 category 里面已经使用了同样的方法名，会导致不可预计的后果。实际上，被调用的是最后被加载的那个 category 中方法的实现(译者注：如果导入的多个 category 中有一些同名的方法导入到类里时，最终调用哪个是由编译时的加载顺序来决定的，最后一个加载进来的方法会覆盖之前的方法)

**推荐：**

```objectivec
@interface NSDate (ZOCTimeExtensions)
- (NSString *)zoc_timeAgoShort;
@end
```

**不推荐：**

```objectivec
@interface NSDate (ZOCTimeExtensions)
- (NSString *)timeAgoShort;
@end
```

# @public 和 @private 标记符
- @public 和 @private 标记符应该以一个空格来进行缩进：

```objectivec
@interface MyClass : NSObject {
 @public
  ...
 @private
  ...
}
@end
```

# 协议（Protocols）

- 在书写协议的时候注意用 <> 括起来的协议和类型名之间是没有空格的，比如 IPCConnectHandler()<IPCPreconnectorDelegate>,这个规则适用所有书写协议的地方，包括函数声明、类声明、实例变量等等：

```objectivec
@interface MyProtocoledClass : NSObject<NSWindowDelegate> {
 @private
    id<MyFancyDelegate> _delegate;
}

- (void)setDelegate:(id<MyFancyDelegate>)aDelegate;
@end
```

# 闭包（Blocks）

- 根据 block 的长度，有不同的书写规则：
	* 较短的 block 可以写在一行内。
	* 如果分行显示的话，block 的右括号 } 应该和调用 block 那行代码的第一个非空字符对齐。
	* block 内的代码采用4个空格的缩进。
	* 如果 block 过于庞大，应该单独声明成一个变量来使用。
	* ^ 和 ( 之间，^ 和 { 之间都没有空格，参数列表的右括号 ) 和 { 之间有一个空格。

```
// 较短的block写在一行内
[operation setCompletionBlock:^{ [self onOperationDone]; }];

// 分行书写的block，内部使用4空格缩进
[operation setCompletionBlock:^{
    [self.delegate newDataAvailable];
}];

// 使用C语言API调用的block遵循同样的书写规则
dispatch_async(_fileIOQueue, ^{
    NSString *path = [self sessionFilePath];
    if (path) {
      // ...
    }
});

// 较长的block关键字可以缩进后在新行书写，注意block的右括号'}'和调用block那行代码的第一个非空字符对齐
[[SessionService sharedService]
    loadWindowWithCompletionBlock:^(SessionWindow *window) {
        if (window) {
          [self windowDidLoad:window];
        } else {
          [self errorLoadingWindow];
        }
    }];

// 较长的block参数列表同样可以缩进后在新行书写
[[SessionService sharedService]
    loadWindowWithCompletionBlock:
        ^(SessionWindow *window) {
            if (window) {
              [self windowDidLoad:window];
            } else {
              [self errorLoadingWindow];
            }
        }];

// 庞大的block应该单独定义成变量使用
void (^largeBlock)(void) = ^{
    // ...
};
[_operationQueue addOperationWithBlock:largeBlock];

// 在一个调用中使用多个block，注意到他们不是像函数那样通过':'对齐的，而是同时进行了4个空格的缩进
[myObject doSomethingWith:arg1
    firstBlock:^(Foo *a) {
        // ...
    }
    secondBlock:^(Bar *b) {
        // ...
    }];
```


# 数据结构的语法糖

- 应该使用可读性更好的语法糖来构造 `NSArray`，`NSDictionary` 等数据结构，避免使用冗长的 `alloc`,`init` 方法。
- 如果构造代码写在一行，需要在括号两端留有一个空格，使得被构造的元素于与构造语法区分开来：

```
// 正确，在语法糖的"[]"或者"{}"两端留有空格
NSArray *array = @[ [foo description], @"Another String", [bar description] ];
NSDictionary *dic = @{ NSForegroundColorAttributeName : [NSColor redColor] };

// 不正确，不留有空格降低了可读性
NSArray* array = @[[foo description], [bar description]];
NSDictionary* dic = @{NSForegroundColorAttributeName: [NSColor redColor]};

```
- 如果构造代码不写在一行内，构造元素需要使用两个空格来进行缩进，右括号 ] 或者 }写在新的一行，并且与调用语法糖那行代码的第一个非空字符对齐：

```
NSArray *array = @[
  @"This",
  @"is",
  @"an",
  @"array"
];

NSDictionary *dictionary = @{
  NSFontAttributeName : [NSFont fontWithName:@"Helvetica-Bold" size:12],
  NSForegroundColorAttributeName : fontColor
};

```
- 构造字典时，字典的Key和Value与中间的冒号:都要留有一个空格，多行书写时，也可以将Value对齐：


```
// 正确，冒号':'前后留有一个空格
NSDictionary *option1 = @{
  NSFontAttributeName : [NSFont fontWithName:@"Helvetica-Bold" size:12],
  NSForegroundColorAttributeName : fontColor
};

// 正确，按照Value来对齐
NSDictionary *option2 = @{
  NSFontAttributeName :            [NSFont fontWithName:@"Arial" size:12],
  NSForegroundColorAttributeName : fontColor
};

// 错误，冒号前应该有一个空格
NSDictionary *wrong = @{
  AKey:       @"b",
  BLongerKey: @"c",
};

// 错误，每一个元素要么单独成为一行，要么全部写在一行内
NSDictionary *alsoWrong= @{ AKey : @"a",
                            BLongerKey : @"b" };

// 错误，在冒号前只能有一个空格，冒号后才可以考虑按照Value对齐
NSDictionary *stillWrong = @{
  AKey       : @"b",
  BLongerKey : @"c",
};

```
