//
//  AppDelegate.swift
//  NeedSwift
//
//  Created by Augus on 2021/3/27.
//

import UIKit


class Point {
    var x: Double,y: Double
    init(x: Double,y: Double) {
        self.x = x
        self.y = y
    }
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        

        
//        testSets();
        
//        testIfElse()
        
//        testClourse()
        
//        testEnum()
        
//        testProperty()
        
//        testInstanceFunc()
        
//        testIndex()
        
//        testInherit()
        
//        testInit()
        
        
//        testImageContext()
//        testImageRenderer()
        
//        testImageDownSample()
//        testImageIO()
        
//        add(a: 1, b: 2)
        
        for _ in 0..<100 {
//            testImageDownSample()
            testImageIO()
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
//    override class func didChange(_ changeKind: NSKeyValueChange, valuesAt indexes: IndexSet, forKey key: String) {
//        <#code#>
//    }

    

}


func add(a: Int,b: Int) -> Int {
    return a+b
}


func testImageContext() {
    
    
    let width = 300.0
    let bounds = CGRect(x: 0, y: 0, width: width, height: width)
    
    // Drawing Code
    UIColor.black.setFill()
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 20, height: 20))
    
    path.addClip()
    UIRectFill(bounds)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    image?.withTintColor(.blue)
    
    
    
}

func testImageRenderer() {
    
    
    let width = 300.0
    let bounds = CGRect(x: 0, y: 0, width: width, height: width)
    
    // Drawing Code
    let renderer = UIGraphicsImageRenderer(size: bounds.size)
    let image = renderer.image { (UIGraphicsImageRendererContext) in
        UIColor.black.setFill()
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: 20, height: 20))
        path.addClip()
        UIRectFill(bounds)
    }
    
    image.withTintColor(.blue)
    
    
}

func testImageDownSample() {
    let path = Bundle.main.path(forResource: "china_big_img", ofType: "jpg")!
    guard let image =  UIImage(contentsOfFile: path) else {
        print("image is nil")
        return
    }

    let scaleSize = CGSize(width: image.size.width * 0.2, height: image.size.height * 0.2)
    let renderer = UIGraphicsImageRenderer(size: scaleSize)
    
    let resizedImage = renderer.image { (UIGraphicsImageRendererContext) in
        image.draw(in: CGRect(x: 0, y: 0, width: scaleSize.width, height: scaleSize.height))
    }
    
    print(resizedImage.size)
    
}


func testImageIO() {
    
    
    let path = Bundle.main.path(forResource: "china_big_img", ofType: "jpg")
    let url = NSURL(fileURLWithPath: path!)
    
    guard let imageSource = CGImageSourceCreateWithURL(url, nil) else { return };
    let options: [NSString: Any] = [
        kCGImageSourceThumbnailMaxPixelSize: 100,
        kCGImageSourceCreateThumbnailFromImageAlways: true
    ]
    
//    CGBitmapContextReleaseDataCallback
    
    guard let scaleImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary) else {
        print("sacle image is nil")
        return
        
    }
    
    let img = UIImage(cgImage: scaleImage)
    let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    imageView.isOpaque = false
    print("scale image size is \(img.size)")
    
}


func testInit()  {
    
    struct Car {
        // 默认的属性值
        var speed: Int = 0
        // 等效于下面
//        init() {
//            speed = 0 or self.speed = 0
//        }
    }
    
    struct Foots {
        var foot: Int = 0
        var name: String?
       
        
        init(person pfoot: Int) {
            foot = pfoot * 3
        }
        
        init(birds bfoot: Int) {
            foot = bfoot * 2
        }
        
        init(_ foots: Int) {
            foot = foots
        }
        
        init(names: String) {
            name = names
        }
        
        init(names: String,foots: Int) {
            name = names
            foot = foots
        }
        
        
        
    }
    
//    let f = Foots(birds: 3)
//    print(f.foot)
//    let f = Foots(names: "niu")
//    guard let name = f.name else {
//        print("f is nil")
//        return
//    }
//    print(name)
    
    
    class Person {

        var name: String?
        var age: Int
        var height: Double?
        // 指定初始化器
        init(n: String,a: Int,h: Double) {
            name = n
            age = a
            height = h
        }
        
        // 便捷初始化器
        convenience init (n: String,a: Int) {
            
            self.init(n: n,a: a,h: 0.0)
        }
    }

    class PersonA: Person {

        init(n: String,h: Double) {
            super.init(n: n, a: 0, h: h)
        }
    }
//
//    let pa = PersonA(n: "niuj", h: 1.73)
//    guard let h = pa.height else {
//        print("h is nil")
//        return
//    }
//    print(h)
    
    
    struct NWSize {
        var width = 0.0
        var height = 0.0
    }
    
    struct NWOrigin {
        var x = 0.0
        var y = 0.0
    }
    
    struct NWRect {
        var size = NWSize()
        var origin = NWOrigin()
        init() {}
        
        init(lsize: NWSize,lorigin: NWOrigin) {
            size = lsize
            origin = lorigin
        }
        
        init(lcenter: Point,lsize: NWSize) {
            let originX = lcenter.x - lsize.width / 2
            let originY = lcenter.y - lsize.height / 2
            self.init(lsize: lsize, lorigin: NWOrigin(x: originX, y: originY))
            
        }
        
    }
    
    
    
//    let r = NWRect()
    
//    struct NWModel {
//        var name: String?
//        var age: Int
//    }
    
    class NWModel: ObservableObject {
        var name: String = "niu"
        var age: Int = 18
       
    }
    
    
    class TestSwiftClass {
        
        var aBool: Bool = true
        var aInt: Int = 0
        var aDouble: Double = 12.23
        var aString: String = "niu"
        var aObject: AnyObject! = nil
    }
    
    
    class TestSwiftVC: UIViewController {
        var aBool: Bool = true
        var aInt: Int = 0
        var aDouble: Double = 12.23
        var aString: String = "niu"
        var aObject: AnyObject! = nil
    }
        
    
//    let aSwiftClass: TestSwiftClass = TestSwiftClass()
//    showClsRunTime(cls: )
//    print("\n")
    
    
    
    
}


func showClsRunTime(cls: AnyClass) {
    print("start methodList")
    var methodCount: UInt32 = 0
    let methodList = class_copyMethodList(cls, &methodCount)
    for index in 0..<numericCast(methodCount) {
        let method = methodList![index]
        let methodType = String(utf8String: method_getTypeEncoding(method)!)
        let methodReturnType = String(utf8String: method_copyReturnType(method))
        let methodName = String(_sel: method_getName(method))
        
        print("type is \(String(describing: methodType)), return type is \(String(describing: methodReturnType)),method name is \(methodName)")
        
    }
    print("end method")
    
    print("start property ")
    var propertyCount: UInt32 = 0
    let propertyList = class_copyPropertyList(cls, &propertyCount);
    for index in 0..<numericCast(propertyCount) {
        let property = propertyList![index]
        print(String(utf8String: property_getName(property)))
        print(String(utf8String: property_getAttributes(property)!))
    }
    print("end property")
    
}


func testInherit() {
    
    class Tandem {
        // final 阻止重写
       var currentSpeed = 0.0
        var description: String {
            return "travel at \(currentSpeed) miles per hour"
        }
        
        func makeNoise() {
            print("Tandem makie noise")
        }
    }
    
    
    class Bicycle: Tandem {
        
        var hasBasket = false
        
    }
    
//    let bicycle = Bicycle()
//    bicycle.hasBasket = true
//
//    bicycle.currentSpeed = 15.0
//    print(bicycle.description)
    
    
    class Tan: Bicycle {
        
        var currentNumbersOfPassengers = 0
        
    }
    
//    let t = Tan()
//    t.currentNumbersOfPassengers = 2
//    t.currentSpeed  = 11
//    print(t.description)
//
    
    class Train: Tandem {
        
        override func makeNoise() {
//            super.makeNoise()
            print("choo choo")
        }
    }
    
    let t = Train()
    t.makeNoise()
    
    
    class Car: Tandem {
        
        var gear = 1
        override var description: String {
            return super.description + " in gear \(gear)"
        }
        
    }
    
//    let c = Car()
//    c.gear = 3
//    print(c.description)
    
    
    class AutoCar: Car {
        
        override var currentSpeed: Double {
            didSet {
                gear = Int(currentSpeed / 10.0) + 1
            }
        }
    }
    
    
    let a = AutoCar()
    a.currentSpeed = 32
    
    print(a.description)
    
    
}


func testIndex() {
    
    
    struct TimesTable {
        
        let multiplier: Int
        subscript(index: Int) -> Int {
            return multiplier * index
        }
    }
    
    
    let t = TimesTable(multiplier: 3)
    let res = t[6]
    print(res)
    
    
    
}


func testInstanceFunc() {
    
    
    class Counter {
        
        var count = 0
        func increment() {
            self.count += 1
            print(count)
        }
        
        func increment(by amount: Int) {
            count += amount
            print(count)
        }
        
        func reset() {
            count = 0
        }
        
        class func decrement() {
            print("this is \(self)")
        }
    }
    
    
    let c = Counter()
    c.increment()
    
    c.increment(by: 5)
    
    c.reset()
    
    Counter.decrement()
    
    
    
    
}

func testProperty() {
    
    
    // 存储属性：会存储常量或则变量作为实例的一部分，存储属性只能由类和结构体定义
    // 变量存储属性和常量存储属性
    
    // 计算属性：会计算值，计算属性可以由类 结构体和枚举定义
    
    // 类型属性
    
    
    struct FixedLengthRange {
        var firstValue: Int
        let length: Int
        
    }
    
    // 如果你设置一个结构体为常量 那么则不允许你更改实例中的属性
    // 如果是类的话，因为是引用类型，则可以进行设置
    var fix1 = FixedLengthRange(firstValue: 0, length: 3)
    fix1.firstValue = 7
//    fix1.length = 4
    
    
//    class DataImporter {
//
//        var fileName = "test.txt"
//    }
//
//    class DataManger {
//
//        lazy var importer = DataImporter()
//        var data = [String]()
//    }
//
//    let manger = DataManger()
//    manger.data.append("123")
//    manger.data.append("456")
//
//    let filename = manger.importer.fileName
//    print(filename)
    
    
    // 计算属性提供一个读取器和一个可选的设置器来间接得到和设置其他的属性和值
    
//    struct O1 {
//        var x = 0
//    }
//    struct On {
//        var o1 = O1()
//        var center: O1 {
//            get {
//                O1(x: o1.x / 2)
//            }
//            set {
//                o1.x = newValue.x / 2
//            }
//        }
//
//        // 只读计算属性
//        var onlyPropertyO1: O1 { O1(x: 3) }
//    }
//    var o1 = On(o1: O1(x: 4))
//    let x = o1.center
//    o1.center = O1(x: 8)
    
//    print("only read property is \(o1.onlyPropertyO1.x)")
    
    
    // 属性观察者
    
//    class StepCounter {
//
//        var totalSteps: Int = 0 {
//
//            willSet(newTotalSteps) {
//                print("about to set total to \(newTotalSteps)")
//            }
//
//            didSet{
//                if  totalSteps > oldValue {
//                    print("add \(totalSteps - oldValue)")
//                }
//            }
//        }
//    }
//
//    let stepCounter = StepCounter()
//    stepCounter.totalSteps = 20
//
//    stepCounter.totalSteps = 30
//
//    stepCounter.totalSteps = 35
    
    
    // 属性包装
    @propertyWrapper
    struct Lower12 {
//        private var number = 0
//        var wrappedValue: Int {
//            get {return number}
//            set {number = min(newValue, 12)}
//        }
        
        // 扩展版本 设置不同的初始值
        private var maxnum: Int
        private var number: Int = 0
        
        var  wrappedValue: Int {
            get {return number}
            set {number = min(newValue, maxnum)}
        }
        
        init() {
            maxnum = 12
            number = 0
        }
        
        init(wappedValue: Int) {
            maxnum = 12
            number = min(wrappedValue, maxnum)
        }
        
        init(wrappedValue: Int,maxnum: Int) {
            self.maxnum = maxnum
            number = min(wrappedValue, maxnum)
        }
        
    }
    
    struct SmallRect {
        @Lower12(wrappedValue: 11, maxnum: 12) var height: Int
        @Lower12 var width: Int
        
        // 等价于
        
//        private var _h = Lower12()
//        private var _w = Lower12()
//
//        var height: Int {
//            get {return _h.wrappedValue}
//            set {_h.wrappedValue = newValue}
//        }
//        var width: Int {
//            get {return _w.wrappedValue}
//            set {_w.wrappedValue = newValue}
//        }
        
    }

//
//    var low = Lower12()
//    low.wrappedValue = 19
//    print(low.wrappedValue)
    
//    var rect = SmallRect()
//    print(rect.height)
//
//    rect.height = 10
//    print(rect.height)
//
//    rect.height = 20
//    print(rect.height)
    
    
    struct AudioChannel {
        static let thresholdLevel = 10
        static var maxInputLevelForAllChannels = 0
        var currentLavel: Int = 0 {
            didSet {
                if currentLavel > AudioChannel.thresholdLevel {
                    currentLavel = AudioChannel.thresholdLevel
                }
                
                if currentLavel > AudioChannel.maxInputLevelForAllChannels {
                    AudioChannel.maxInputLevelForAllChannels = currentLavel
                }
            }
        }
    }
        
    
    
    
}

func testEnum() {
    
    
    // 值类型
    
    enum NWDirection: String,CaseIterable {
        
        case north
        case south
        case east
        case west
    }
    
    enum Planet {
        case mercury,venus,earth,mars,jupiter,saturn,uranus
    }
    
//    var d1: NWDirection
//    d1 = .north
    
    
    
    let d = NWDirection.east
    print("type is\(type(of: d)) and value is \(d) and all is \(NWDirection.allCases.count)")
    
//    let p = Planet.
    
    for d in NWDirection.allCases {
        print(d)
    }
    
//    NWDirection.east.rawValue
    
//    let res = Resolution()
    
    // struct 和 enum 是值类型
    let res1 = Resolution(width: 600, height: 800)
    
    var high = res1
    print(high.width)
    
    high.width = 1280
    print("high width is \(high.width) and res1 width is \(res1.width)")
    
    
    // class 是引用类型
    let ten = VideMode()
    ten.res = res1
    ten.interlaced  = true
    ten.name = "1080i"
    ten.frameRate = 25.0
    
    let add1 = String(format: "%p", ten.frameRate)
    
    let alsoTen = ten
    alsoTen.frameRate = 30.0
    let add2 = String(format: "%p", alsoTen.frameRate)

    // ten adn alsoTen本身并没有存储VideMode实例，相反，他们都在后台指向了VideMode实例
    // 这是VideoMode的framerate参数在改变而不是引用videoMode的常量的值的改变

    // 对同一实例的不同命名而已
    print("ten framerate is \(ten.frameRate):\(add1) and also frame is \(alsoTen.frameRate):\(add2)")
    
    
    // 寻找常量或者变量是否引用相同实例
    if ten === alsoTen {
        print("ten === alsoTen")
    } else {
        print("ten !== alsoTen")
    }
    
    // swift中常量或变量指向某个实例的引用类型
    
    
    //
    
}

struct Resolution {
    var width = 0
    var height = 0
    
}

class VideMode {
    
    var res = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


func testClourse() -> Void {
    
    // 闭包能够捕获和存储定义在其上下文中的任何常量和变量
    // 这也就是所谓的闭合并包裹那些常量和变量，所以称为闭包
    
    
//    { (name: String) -> Int in
//
//        print("it is name = \(name)")
//    }
    
    
//    let names = ["niu","wei","gap","tian"]
//    let reverseNames = names.sorted(by: back0(_:_:))
//    print(reverseNames)
    
    
//    let reverseNames = names.sorted { (s1, s2) -> Bool in
//        return s1 > s2
//    }
//    print(reverseNames)
    
    // in 关键字表示，闭包的形参部分和返回类型已经定义完成，闭包的函数体即将开始
    
//    let reverseName = names.sorted(by: <)
//
//    print(reverseName)
    
//    tailClourse {
//
//        print("111")
//    }
    
//    let array = [1,501,43,21]
//    let digitNames = [
//       0: "Zero",1: "One",2: "Two",  3: "Three",4: "Four",
//       5: "Five",6: "Six",7: "Seven",8: "Eight",9: "Nine"
//    ]
//
//    let str = array.map { (s1) -> String in
//        var number = s1
//        var output = ""
//        while number > 0 {
//            output = digitNames[number % 10]! + output
//            number /= 10
//        }
//        return output
//
//    }
//    print(type(of: str))
    
    
//    let res = captureValue(5);
//    let tmp0 = res()
//    let p0 = String(format: "%p", tmp0);
//    print("tmp0 add is \(p0)")
//    let tmp1 = res()
//    let p1 = String(format: "%p", tmp1);
//    print("tmp0 add is \(p1)")


//    let completionHandlers: [()-> Void] = []
//    print(type(of: completionHandlers))
    
//    let scls = someClass()
//    scls.doSomething()
//    print(scls.x)
    
//    completionHandlers.first!()
//    print(scls.x)
    
    
    
    var nums = [8,3,4,5,9]
//    print(nums.count)
//
//    let removeClosure = { nums.remove(at: 0) }
//    print(nums.count)
//
//    let res = removeClosure()
//    print("item is \(res) and left count is \(nums.count)")
    
//    nw_service(cus: {nums.remove(at: 0)})
    
//    nw0_service(nums.remove(at: 3))
    
    nw1_service(nums.remove(at: 0))
    nw1_service(nums.remove(at: 0))
    
    print("service person count is \(servicePersons.count)")
    
    for p in servicePersons {
        print("now service p is \(p())")
    }
    
    
    
}

var servicePersons: [ ()-> Int ] = []
func nw1_service(_ person: @autoclosure @escaping () -> Int) {
    servicePersons.append(person)
}



func nw_service(cus customer: () -> Int) {
    print("now service \(customer())")
}

func nw0_service(_ customer: @autoclosure () -> Int) {
    print("now0 service \(customer())")
}


// 存储逃逸闭包的数组
var completionHandlers: [()-> Void] = []

// 逃逸闭包作为参数进行形参
func someFuncWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

//
func someNoneEscaping(closure: ( ) -> Void) {
    closure()
}


class someClass {
    var x = 10
    func doSomething()  {
        someNoneEscaping { x = 20 }
        someFuncWithEscapingClosure {[self] in
            print(type(of: self))}
            x = 35
    }
}

struct someStruct {
    var x = 10
    // 结构体和枚举都是值类型
    // 默认情况下，值类型是不能被自身的实例方法所修改
    // 可以在func关键字前面加上mutating关键字来指定实例方法可以修改
    
    
    mutating func doSomething() {
        someNoneEscaping {
            // 可以给隐藏关键字self赋值
            self.x = 30
        }
        
//        someFuncWithEscapingClosure {
//            x = 200
//        }
    }
}


// 捕获值

func captureValue(_ amount: Int) -> () -> Int {
    
    var total = 0;
    func increase() -> Int {
        total += amount
        print(total)
        return total
    }
    return increase
}

func tailClourse(cls: () -> Void) -> Void {
    print("it is a tail clourse")
}

func back0(_ s1: String,_ s2: String) -> Bool {
    return s1 < s2;
}


func testIfElse() -> Void {
    
//    for i in 0...4 {
//        print(i)
//    }
    
//    var sum = 0
//    let base = 3
//
//    let t1 = CACurrentMediaTime()
//    for _ in 0..<1000000 {
//        sum += base
//    }
//    print("_ time is \(CACurrentMediaTime() - t1)")
//
//
//    var sum1 = 0
//    let t2 = CACurrentMediaTime()
//    for i in 0..<1000000 {
//        sum1 += base
//    }
//    print("i time is \(CACurrentMediaTime() - t2)")

    
    
    
//    let v = [1,2,3]
//    let someV = v.first
//
//    switch someV {
//    case 1:
//        print("v is 1")
//        fallthrough
//    case 3:
//        print("v is 3")
//    case 2:
//        print("v is 2")
//
//    default:
//        print("v is default")
//    }
    
    
//    let p1 = (1,-1)
//    let p2 = (1,2)
//    switch p1 {
//    case let(x,y) where x == -y:
//        print("x = -y")
//    case let(x,y) where x == y:
//        print("x = y")
//    default:
//        print("x != y")
//    }
    
    // 给循环打标签
//    gameLoop : while p1 != p2 {
//
//
//    }
    
//    let s1: String? = ""
//    guard let s = s1 else {
//        print("s1 is nil")
//        return
//    }
//
//    print("s is \(s)")
//
//
//    if #available(iOS 8.0,macOS 10.0,watchOS 10.0, *) {
//
//        print("iOS > 8,macOS > 10,watchOS > 10")
//    } else {
//        print("lower")
//
//    }
    
//    { (<#parameters#>) -> <#return type#> in
//        <#statements#>
//    }
    
    
//    clourse();
    
//    (^block)(NSString *name){
//
//
//    }
    
//    let nums = [Int]()
//    let res = maxMin(array: nums)
    
    // 可选项绑定
    
    
    // guard 提前返回
//    guard let res = maxMin(array: nums) else {
//        print("res is ni")
//        return
//    }
//
//    print(res)
    
    
//    greeting(name: <#T##String#>)
//    greeting(name: <#T##String#>, nam1e: <#T##String#>)
    
//    greeting(me: "niu", "gao")
    
//    greeting(me: <#T##String#>, other: <#T##String#>)
    
//    greeting(me: <#T##String#>, nam1e: <#T##String#>)
    
//    greeting(me: <#T##String#>, <#T##nam1e: String##String#>)
    
    
//    greeting2("niu")
//    greeting2("niu", 19)
    
    
//    testOptionParam(nums: 1.1,2.0,3.4)
    
//    var name = "test"
//    let res = greeting3(&name)
//    print(res)
    
    
//    var a = 1
//    var b = 2
//
//    nwSwap(&a, &b)
//
//
//
//    print("a is \(a) and b is \(b)")
    
//    let func1: (String, Int) -> Void = greeting2
//    func1("gao",10)
    
//    let func2 = greeting2
//    func2("tian",1)
    
//    printMathResult(func2, "augus")
    
    let curren = 3
//    let stp = chooseStep(curren > 0)
//    let cur = stp(curren)
//    print(cur)
    
    let step = chooseStep1(curren > 0)
    let cur = step(curren)
    print(cur)
    

}


func chooseStep(_ backwors: Bool) -> (Int) -> Int {
    
    return backwors ? stepBackword : stepForward
}


func chooseStep1(_ backwords: Bool) -> (Int) -> Int {
    
    func stepForward(_ step: Int) -> Int {return step + 1}
    func stepBackward(_ step: Int) -> Int {return step - 1}
    return backwords ? stepBackword : stepForward;
}


func stepForward(_ step: Int) -> Int {
    step + 1
}

func stepBackword(_ step: Int) -> Int {
    step - 1
}


func printMathResult(_ func2: (String, Int) -> Void,_ name: String, _ age: Int = 10) -> Void {
    
    func2(name,age)
}


func nwSwap(_ a: inout Int,_ b: inout Int){
    
    let tmp = a
    a = b
    b = tmp
}



func testOptionParam(nums: Double...) -> Void {
    
    
    var total: Double = 0
    for num in nums {
        total += num
    }
    
    print(total)
}


func greeting2(_ name: String,_ age: Int = 18){
    print("name is \(name) and age is \(age)")
}

func greeting3(_ name: inout String) -> String {
    name = "wei"
    return name
}


// me:实际参数标签 name形式参数名
// me可以使用 _ 代替实际参数标签
// 形参 = 实际参数标签 + 形式参数名
func greeting(me name: String,_ nam1e: String) -> String {
    "Hello" + name + "!"
}


func maxMin(array: [Int]) -> (min: Int,max: Int)? {
    
    if array.isEmpty {
        return nil
    }
    
    var min = 0
    var max = 0
    
    for v in array {
        if v < min {
            min = v
        } else if v > max {
            max = v
        }
    }
    return (min,max);
}



func clourse() -> () {
    
    print("func is no name")
}

// Void == 空的元组> ()
func testSets() -> Void {
    
    // init array
    
//    var nums = [Int]()
//    nums.append(3)
//
//    nums = []
//
//    print("nums count is \(nums.count)")
    
    
//    var doubleArray = Array(repeating: 0.0, count: 3)
//    print("doubleArray is \(doubleArray)")
//    var shoppingList: [String] = [""]
//
//    shoppingList.append("egg")
//    shoppingList.insert("apple", at: 1)
    
//    if shoppingList.isEmpty {
//
//        print(shoppingList)
//    } else {
//        print("is not empty")
//    }
    
//    print(shoppingList)
//
//    shoppingList[1...2] = ["a","b","c"]
//
//    print(shoppingList)
//
//    shoppingList.remove(at: 0)
//
//    for (index,value) in shoppingList.enumerated() {
//        print("index is \(index) and value is \(value)")
//    }
//
//    let hashTest = shoppingList[0].hash
//    // 对象的hash就是对象的内存地址的十进制
//    print(hashTest)
//    let address = String(format: "%p", hashTest)
//
//    print("test add is \(address)")
    
    /*
     
     1062
     test add is 0x426 => 1062
     16^0 * 6 + 16 ^ 1 * 2 + 16 ^ 2 * 4 = 6 + 32 + 1024 = 1062
     */
    
    
//
//    let s1: Set<Int> = [1,3,5,7]
//    let s2: Set<Int> = [2,3,6,7]
//
//    //s1 s2的交集部分
//    let s3 = s1.intersection(s2)
//    print(s3)
    
    // s1和s2 的不交集的部分
//    let s4 = s1.symmetricDifference(s2)
//    print(s4)
//
//    // s1+s2
//    let s5 = s1.union(s2)
//    print(s5)
//
//    // 不包括s2
//    let s6 = s1.subtracting(s2)
//    print(s6)
    
    
    var dict: [Int: String] = [1 :"niu"]
    dict[1] = "one"
    print(dict)

//    dict = [:]
//    print(dict)
    
//    if let v = dict.updateValue("onee", forKey: 1) {
//
//        print("old value is \(v)")
//    } else {
//        print("old value is none")
//    }
//
//    print(dict)
    
    if let v = dict[2] {
        print("one's value is \(v)")
    } else {
        print("one's valu is no exist")
    }

    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

func testString() -> Void {
    
    // how to convert
//        let hexadecimalDouble = 0xC.3p0
//        print(hexadecimalDouble)
    
    //
    
    var optionInt: Int?
    
    let someString = "12S"
    optionInt = Int(someString)

    
    // 可选绑定项
    if let res1 = optionInt {
        print("res1 is \(res1)")
    } else {
        print("res1 is nil")

    }
    
//        let forcedString: String! = "it is a unwarpped string"
//        let test = forcedString
//
//        print(test)
    
//        let age = -3
//        assert(age > 0,"a person's age is must bigger zero")
    
//        assertionFailure("person age is not zeros")
    // 强制先决条件
//        precondition(age > 0, "person age is not zero")
    // 未实现功能的占位代码
//        fatalError("unimplemented")
    
//        let array = [2,2,3,4,9]
//        for value in array[2...] {
//            print(value)
//        }
    
    
//        for i in 1..<5 {
//            print("i is \(i)")
//        }
    
//        let names = ["miu","wei","gao"]
//        print("names joined is \(names)")
    
    

    
//        let p = Point(x: 2, y: 4)
//        print(p)
    
//        let testStr = #"Line 1\nLine 2"#
//        print(testStr)
    
    // 显示特殊符号
    print(#"6 times 7 \n is \(6 * 7)"#)
    
    //
    
//        let c: Character = 'a'
    
//        let s1 = " "
//        if s1.isEmpty {
//            print("s1 character isEmpty is \(s1.count)")
//
//        } else {
//            print("s1 character no empty is \(s1.count)")
//        }
    
//        let word = "cafe 🐻"
//        print("word0 is \(word) count is \(word.count)")
//
//        word += "\u{301}"
//        print("word1 is \(word) count is \(word.count)")

    
    
//        let s1 = "cafe"
//        print(s1[s1.startIndex])
//
//        print(s1.last!)
    
//        print(s1[s1.index(after: s1.startIndex)])
//
//        print(s1[s1.index(s1.startIndex, offsetBy: 2)])
    
//        print(s1[s1.index(before: s1.endIndex)])
    
//        for index in s1.indices {
//            print("index is \(index) and value is \(s1[index])")
//        }
    
    var s1 = "niu"
//        s1.insert(contentsOf: "wei", at: s1.endIndex)
    s1.insert("!", at: s1.endIndex)
    print(s1)
    
//        s1.remove(at: s1.startIndex)
//        print(s1)
//        let range = s1.index(s1.endIndex, offsetBy: -3)..<s1.endIndex
//        s1.removeSubrange(range)
//        print(s1)
    
//        let index = s1.index(s1.endIndex, offsetBy: -5)..<s1.endIndex
//        s1.removeSubrange(index)
//        let s2 = String(s1)
//        print(s2)
    
    for u8 in s1.utf8 {
        print(u8)
    }
    
    for u16 in s1.utf16 {
        print(u16)
    }
    
    for us in s1.unicodeScalars {
        print(us)
    }
}


func testLengthAndCount() -> Void {
    
    // NSString length:基于在字符串的 UTF-16 表示中16位码元的数量来表示的，而不是字符串中 Unicode 扩展字形集群的数量。
    
    let s2 = "🐻"
    print(s2.utf16.count)
    
    
    // String count:Unicode 扩展字形集群的数量。比如一个🐻的编码正常为单个字符的2倍，但是在count中仍然显示1个长度

    
    let att = NSMutableAttributedString(string: s2)
    att.addAttributes([.foregroundColor :UIColor.red], range: NSRange(location: 0, length: s2.count));
    print(att)
    
    
    let att1 = NSMutableAttributedString(string: s2)
    att1.addAttributes([.foregroundColor :UIColor.red], range: NSRange(location: 0, length: s2.utf16.count));
    print(att1)
}


func testStringInit() -> Void {
    let time1 = CACurrentMediaTime()
    
    for index in 0..<1000000 {
        let test1 = String()
        print(index)
        
    }
    let time2 = CACurrentMediaTime() - time1
    print("string() time is \(time2)")
    // 7.4822329390008235
    
    let time3 = CACurrentMediaTime()
    
    for index in 0..<1000000 {
        let test1 = ""
        print(index)
        
    }
    let time4 = CACurrentMediaTime() - time3
    print("string .. time is \(time4)")
    // 4.659638051998627
}

// 增加自定义打印输出
extension Point: CustomStringConvertible {
    var description: String {
        return "Point : (\(x),\(y))"
    }
}

// 字符串插值
extension String.StringInterpolation {
    
    mutating func appendInterpolation(_ values: [String]) {
        
        appendLiteral(values.joined(separator: ","))
        
    }
}

