//
//  ContentView.swift
//  SwiftDataStructure
//
//  Created by Augus on 2021/6/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
        
       
        testStructure()
        
        
        
    }
}


func testTailing(closure: @escaping () -> Void)  {
    
    
    
}

func testClosure() {
    
//    @escaping
//    @auto
    
    
    
    
    let digits = [1,51,65]
    let digitsStr = digits.map {
        String($0)
    }
    print(digitsStr)
}

/// Test Some func

func testStructure() -> some View {
    
    struct NWPoint {
        
        var x: Int = 3
        var y: Int = 4
        
//        init(x: Int,y: Int) {
//            print("nwpoint init")
//            self.x = x
//            self.y = y
//        }
    }
    
    
//    print(MemoryLayout<NWPoint>.size) // 实际占用空间
//    print(MemoryLayout<NWPoint>.stride) // 分配给结构体的空间
//    print(MemoryLayout<NWPoint>.alignment) // 对齐方式
    
    
    
    
    //结论1:编译器会为结构体生成一个或者多个初始化构造，一次初始化保证所有成员都有初始值

    /**
     没有初始化
     struct NWPoint {
     
         var x: Int
         var y: Int
     }
     */
//    let p0 = NWPoint(x: 0, y: 10)
//    let p1 = NWPoint(y: 0)
//    let p2 = NWPoint(y: 2)
    
    //
    /**
        初始化
     struct NWPoint {
         
         var x: Int = 0
         var y: Int = 0
     }
     */
//    let p0 = NWPoint()
//    let p1 = NWPoint(x: 1)
//    let p2 = NWPoint(y: 3)
    
    
    /**
     可选变量
     struct NWPoint {
         
         var x: Int?
         var y: Int?
     }
     */
//    let p0 = NWPoint(x: 2, y: 3)
//    let p1 = NWPoint(x: 4)
//    let p2 = NWPoint(y: 5)
//    let p3 = NWPoint()
    
    
    // 结论2 如果struct 自定义了初始化方法，则不再调用系统的
//    let p0 = NWPoint(x: 4, y: 8)
//    withUnsafePointer(to: &p0) { ptr  in
//
//
//    }
    
    // 访问某种特定类型的指针
//    UnsafePointer 可变
//    UnsafeMutablePointer 不可变
   
    
    // 一组连续的指针
//    UnsafeBufferPointer 不可变
//    UnsafeMutableBufferPointer 可变
    
    // 一种用于访问的原始指针
//    UnsafeRawPointer
//    UnsafeMutableRawPointer
    
    // 用于访问容器类对象元素的指针
//    UnsafeRawBufferPointer
//    UnsafeMutableRawBufferPointer

    
    
//    print("p0 x is\(p0.x) and y is \(p0.y)")
//    print("p0 x is\(p1.x) and y is \(p0.y)")
//    print("p0 x is\(p2.x) and y is \(p0.y)")
    
    // 结论3 属性的存储地址是连续的
    
//    let p0 = NWPoint(x: 0, y: 3)
//    withUnsafePointer(to: p0) { ptr in
//        print("p0 addr is \(ptr)")
//    }
//
//    withUnsafePointer(to: p0.x) { ptr in
//        print("p0x addr is \(ptr)")
//    }
//
//    withUnsafePointer(to: p0.y) { ptr in
//        print("p0y addr is \(ptr)")
//    }
    
    // 类 编译器不会为类生成可以传入成员变量的初始化器
    // 如果具有初始化值，则会自动生成无参的初始化函数
    // 如果没有初始化值，不会调用无参的初始化函数
    
    // 结论4:如果类定义的时候为其初始化成员的值，那么编译器会自动生成无参数初始化器
    

    
//    let p0 = GTPoint()
//    let p1 = GTPoint(x: 3) error
//    let p2 = GTPoint(y: 2) error
//    let p3 = GTPoint(x: 4, y: 9) error
//    print("p0 is \(p0.x)")
    

    // 区别
    // struct 是值引用，class是指针引用
    // struct的赋值属于深拷贝，赋值前后是不同的副本
    // class的赋值是浅拷贝，同一个内存地址
    // struct不支持继承，class支持继承
    
    
    // 内存分布
    /**
     如果值类型在函数里面，就放在栈空间，point里面有x y 共16个字节
     
     */
//    let p1 = NWPoint() // struct
//    let gt = GTPoint() // class
//
//    print("class size \(MemoryLayout.size(ofValue: gt)),stride is \(MemoryLayout.stride(ofValue: gt)),alignment is \(MemoryLayout.alignment(ofValue: gt))")
    
    
    // 测试ptr
//    testPtr()
    
//    testCodable()
    
//    let time = testFuncTime(f: testCodable)
//    print("time is \(time)")
    
//    testThrows()
//    testOOP()
    
//    testAsync()
    
//    testClosure()
    
    
//    testSmallNum()
    
    
//    testIndirectEnum()
    
//    let counter = Counter()
//    counter.increase(by: 5)
//    print(counter.count)
//
//    counter.increase()
//    print(counter.count)
    

//    let p = Point2(x: 4, y: 3)
//    if p.compare(x: 2) {
//        print("point is x")
//    }
    
    
//    var p = Point3(x: 1, y: 2)
//    p.move(x: 2, y: 4)
//    print("x is \(p.x) and y is \(p.y)")
    
    
//    var tri = TriStateSwitch.low
//    tri.next()
//    switch tri {
//    case .off:
//        print("off")
//    case .low:
//        print("low")
//    case .high:
//        print("high")
    
    
//    isMan(10)

    
//    testClosure1()
    
    let tt = TimesTable(num: 3)
    print(tt[6])
    
    return Text("Niu").padding()
}


class TestCar {
    
    var currentSpeed: Double = 0.0
    var description: String {
        return "The car is driving on speed of \(currentSpeed)"
    }
}


class Car: TestCar {
    var gear = 1
    override var description: String {
        return super.description + "in gear of \(gear)"
    }
}

class Bicycle: Car {
    override var currentSpeed: Double {
        didSet {
            gear += Int((currentSpeed / 10.0))
        }
    }
}


/// subscripts

struct TimesTable {
    let num: Int
    subscript(index: Int) -> Int {
        return num * index
    }
}



func testClosure1()  {
    
    
    var array = ["niu","wei","gao"]
    // some one way to sorted
//    let reverseArray = try array.sorted(by: sortedd(n:m:))
    
    //
//    let reverseArray = try array.sorted(by: (s1: String,s2: String) -> Bool {
//        return s1 > s2
//    })

//    let reverseArray = try array.sort(by: { s1, s2 in
//        return s1 > s2
//    })
//
//
//    let reverseArray2 = try array.sorted(by: { s1, s2 in
//        return s1 > s2
//    })
//    print("1 is \(reverseArray)")
//    print(reverseArray2)
    
    // two way
//    let reverseArray = array.sorted(by: {(s1: String,s2: String) -> Bool in
//
//        return s1 > s2
//    })
    
    // three way (type infer)
//    let reverseArray = array.sorted(by: {(s1,s2) in
//
//        return s1 > s2
//    })
    
    // four way
//    let reverseArray = array.sorted(by: {(s1,s2) in
//        s1 > s2
//    })
    
    
    // five way auto variable from complie
//    let reverseArray = array.sorted(by: {$0 > $1})
    
    // six way
//    let reverseArray = array.sorted(by: >)
//    print(reverseArray)
    
//    {(s1: String,s2: String) -> Bool in
//
//        #statement
//    }
    
    var nums = [16,58,510]
    
    let stringDict = [
        1 : "one",2 : "two",3 : "three",4 : "four",5 : "five",
        6 : "six",7 : "seven",8 : "eight",9 : "nine",0 : "zero"
    ]
    
    
    // to Strings = [onesix,five,fiveonezero]
    
    let strings = nums.map({(num) -> String in
        
        var number = num
        var count = ""
        
        repeat{
            let temp = stringDict[number % 10]!
            number /= 10
            count = temp + count
        } while (number > 0)
        
        return count
    })
    
    print(strings)
    
    
    
    
//    print(reverseArray)
//    array.sorted(by: <#T##(String, String) throws -> Bool#>)
}

/// func to sorted paramteric ===> some one way
func sortedd(n: String,m: String) -> Bool {
    return n > m
}



@discardableResult func isMan(_ age: Int) -> Bool {
    return age > 18
}


/// enum for mutating

enum TriStateSwitch {
    case off,low,high
    
   mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}


/// mutating

struct Point3 {
    var x = 0.0,y = 0.0
    mutating func move(x offsetX: Double,y offsetY: Double)  {
        
        // version1
//        x += offsetX
//        y += offsetY
        
        // verison2
        self = Point3(x: x + offsetX, y: y + offsetY)
    }
}


/// about self

struct Point2 {
    var x = 0,y = 0
    
    func compare(x: Int) -> Bool {
        return self.x > x
    }
}

/// 递归枚举
func testIndirectEnum() {
    
    
    indirect enum week2 {
        case Monday
        case Tuesday
    }

}


class Counter {
    
    var count = 0
    
    func increase()  {
        count += 1
    }
    
    func increase(by amount: Int) {
        count += amount
    }
    
    func reset()  {
        count = 0
    }
}


func testSmallNum() {
    
    let width = SmallNumber(wrappedValue: 21,max: 20).wrappedValue
    print("width is \(width)")
    
    
//    @SmallNumber var height
//    @SmallNumber var w_width
//    print("sh is \(sh.wrappedValue)")
    
    

//    var sr = SmallRectangle()
//    print(sr.height)
//    sr.height = 13
//    print(sr.height)
//    sr.width = 10
//    print(sr.width)
    
    
//    var sm1 = SmallRect1()
//    print(sm1.height)
//    sm1.height = 18
//    print(sm1.height)
    
    
//    var sm2 = SmallRect2()
//    sm2.width = 3
//    print(sm2.width)
//    sm2.width = 18
//    print(sm2.width)
    
    
//    var rect = smallRectPro()
//    rect.someNum = 9
//    print(rect.someNum)
//    print(rect.$someNum)
//
//    rect.someNum = 19
//    print(rect.$someNum)
    
    
    var sr = SizedRect()
//    print(sr.height)
//    sr.height = 19
//    sr.width = 20

    let isLarge = sr.resize(to: .small)
    print(isLarge)
    
}


enum Size {
    case small,large
}

struct SizedRect {
    @smallNumerPro var height: Int
    @smallNumerPro var width: Int
    
    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 2
        case .large:
            height = 100
            width = 200
        }
        print("$width is large \($width) and height is large \($height)")
        return $width || $height
    }
}

struct SmallRect2 {
    
    
    // call init()
    //    @SmallNumber var height: Int

//    @SmallNumber var height: Int = 18
    // call init(wrappedValue:)
//    @SmallNumber var width: Int = 3
    
    // call init(w: max:)
//    @SmallNumber(wrappedValue: 3, max: 18) var height: Int
    // call init(wrappedValue:)
    @SmallNumber(wrappedValue: 4) var width: Int
    //
    @SmallNumber(max: 9) var height: Int = 2
}


struct smallRectPro {
    @smallNumerPro var someNum: Int
}


@propertyWrapper
struct smallNumerPro {
    
    private var number: Int = 0
    var projectedValue = false
    
    var wrappedValue: Int {
        get {
            return number
        }
        
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            } else {
                number = newValue
                projectedValue = false
            }
        }
    }
}


struct SmallRect1 {
    private var _height = SmallOne()
    private var _width = SmallOne()
    
    var height: Int {
        get {
            return _height.wrappedValue
        }
        
        set {
            _height.wrappedValue = newValue
        }
    }
    
    var width: Int {
        get {
            return _width.wrappedValue
        }
        
        set {
            _width.wrappedValue = newValue
        }
    }
}

struct SmallRectangle {
    @SmallOne var height: Int
    @SmallOne var width: Int
}


@propertyWrapper
struct SmallOne {
    private var num = 0
    var wrappedValue: Int {
        get {
            
            return num
        }
        set {
            num = min(newValue, 12)
        }
    }
}

@propertyWrapper
struct SmallNumber {
    
    private var number: Int
    private var maxNum: Int
    
    var wrappedValue: Int {
        get {
            return number
        }
        
        set {
            number = min(newValue, maxNum)
        }
    }
    
    init() {
        maxNum = 12
        number = 0
    }
    
    init(wrappedValue: Int) {
        maxNum = 12
        number = min(wrappedValue, maxNum)
    }
    
    init(wrappedValue: Int,max: Int) {
        self.maxNum = max
        number = min(wrappedValue, maxNum)
    }
    
}



func testAsync()  {
    
    
    let backQueue = DispatchQueue.init(label: "com.fosafer.backqueue")
    backQueue.async {
        print("async and back queue")
        
        
        DispatchQueue.main.async {
            print("main queue operator")
        }
        
    }
    
    
}


class Animal {
    
    var leg: Int { return 2}
    func eat() {
        print("eat food")
    }
    
    func run() {
        print("run with leg of \(leg)")
    }
}

class Sheep: Animal {
    override var leg: Int {return 4}
    override func eat() {
        print("eat grass")
    }
    
}

protocol Lovegao {
    var name: String { get }
    func greet()
}

struct Person: Lovegao {
    var name: String
    
    func greet() {
        print("hello \(name)")
    }
}

struct Cat: Lovegao {
    var name: String
    func greet() {
        print("cat say \(name)")
    }
}


protocol Pfunc {
    // 只是定义 不会实现
    func myMethod()
}

//extension Person: Pfunc {
//    func myMethod() {
//        print("person mymethod")
//    }
//}
//
//extension Cat: Pfunc {
//    func myMethod() {
//        print("cat mymethod")
//    }
//}

/// 协议扩展
extension Pfunc {
    func myMethod() {
        print("my method")
    }
    
    func myMethod1() {
        print("my method1")

    }
}

extension Person: Pfunc {}
extension Cat: Pfunc {}


protocol Nameable {
    var name: String {get}
}

protocol Identifiable {
    var name: String {get}
    var id: Int {get}
}


struct Person1: Nameable,Identifiable {
    let name: String
    let id: Int
}

extension Nameable {
    var name: String {return "a default name"}
}

extension Identifiable {
    var name: String {return "other name"}
}



func testOOP() {
    
//    let sheep1 = Sheep()
//    sheep1.eat()
    
//    Person(name: "niu").greet()
    
    // pop 解决oop下的一些问题
    // 动态派发问题解决
//    let array: [Lovegao] = [Person(name: "gao"),Cat(name: "xiaohua")]
//    for lg in array {
//        lg.greet()
//    }
    
//    Person(name: "wei").myMethod()
//    Cat(name: "mou").myMethod()
    
//    Person(name: "wei").
    
//    Person1(name: "augus", id: 10)
    
    

    
    
    // http & pop
    
//    let request = UserRequest()
//    request.send { (user) in
//        
//        if let user = user {
//            print("\(user.name)'s email is \(user.email)")
//        }
//        
//        print("res--- end ")
//    }
//    
//    print("res --- begin")
    
    
    // 重构之后调用
    URLSessionClient().send(UserRequest()) { (user) in
        if let user = user {
            print(user)
        }
        
    }

    
}

func testThrows()  {
    
    struct Student: Codable {
        var name: String?
        var age: Int?
    }
    
    let student = Student(name: "gao", age: 19)
    let encoder = JSONEncoder()
    do {
        let data = try encoder.encode(student)
        let json = String(decoding: data, as: UTF8.self)
        print("data is \(json)")
    } catch let error as NSError {
        // 发生了错误
        print("encode happen error: \(error)")
    }

    
}

class GTPoint {
    
    var x: Int = 3
    var y: Int = 4
    
    init() {
        print("GTPoint init")
    }
}



func incrementor(ptr: UnsafeMutablePointer<Int>) {
    
    ptr.pointee += 1
}


func testCodable() {
    
    
    struct SHUser: Codable {
        var name: String
        var age: Int
    }
    
    do {
        
        // struct - json
        let user = SHUser(name: "niu", age: 19)
        let encoder = JSONEncoder()
        let data = try encoder.encode(user)
        let jsonString = String(decoding: data, as: UTF8.self)
        print("jsonString is \(jsonString)")
        
        // json - struct
        let decoder = JSONDecoder()
        // string to data
        
        let data1 = jsonString.data(using: .utf8)!
        
        let user1 = try decoder.decode(SHUser.self, from: data1)
        print("user1 is \(user1)")
        
        
        
    } catch  {
        print("happen an error: (\(error)")
    }

    
    
    
}

func testPtr()  {
    
    // 一个指针的三种状态
    
    // 内存没有被分配，是一个null指针，或者之前被释放过
    // 内存进行了分配，但是值没有被初始化
    // 内存进行了分配，并且值被初始化
    
    // 申请一个Int类型的指针地址
    var intPtr = UnsafeMutablePointer<Int>.allocate(capacity: 1)
    print("int ptr \(intPtr)")
    
    // 对指针指向的内容进行初始化
    intPtr.initialize(to: 10)
    print("int ptr val \(intPtr.pointee)")
    
    
    // 完成初始化，我们就可以通过pointee来操作指针指向的内存值了
    
    
    // 使用完成，我们尽快释放指针指向的内容和指针本身
    intPtr.deinitialize(count: 1) // 销毁指针指向的对象
    intPtr.deallocate()// 释放之前申请的内存
    // 赋值指针为nil
//    intPtr = nil
    
    
    // 指向指针的数组
//    let a: [Float] = [1,2,3,4]
//    let b: [Float] = [0.6,0.25,0.125,0.0625]
//    var res: [Float] = [0,0,0,0]
//    vDSP_vadd(a, 1, b, 1, &res, 1, 4)
    
    // now res contains[1.5,2.25,3.125,4.0625]
    
    
    // 使用指针操作数组
    var arr = [1,2,3,5,7,8]
    var arrPtr = UnsafeMutableBufferPointer<Int>(start: &arr, count: arr.count)
    
    if let basePtr = arrPtr.baseAddress {
        print(basePtr.pointee)
        basePtr.pointee = 10
        print(basePtr.pointee)
        
        // next item
        let nextPtr = basePtr.successor()
        print(nextPtr.pointee)
    }
 
    
    // 指针操作和转换
    // 可变指针的引用
    var aNum = 8
    aNum = withUnsafeMutablePointer(to: &aNum, { (ptr: UnsafeMutablePointer<Int>) in

        ptr.pointee += 1
        return ptr.pointee
    })
    print("aNum is \(aNum)")
    
    
    //  该接口是在Swift的类型管理之外进行的，因此编译器无法确保得到的类型是否确实正确，你必须明确地知道你在做什么
    // 将一个指针指向的内存强制按位转换成目标类型
    
    let array = NSArray(object: "niu")
    let str = unsafeBitCast(CFArrayGetValueAtIndex(array, 0), to: CFString.self)
    print("str is \(str)")
    
    
    // UnsafePointer<Int> -> unSafePointer<Void>
    let count = 100
    let countPtr = withUnsafePointer(to: count) { (ptr: UnsafePointer<Int>) -> UnsafePointer<Void> in
        return  unsafeBitCast(count, to: UnsafePointer<Void>.self)
    }
    
    // UnSafePointer<Void> -> UnSafePointer<Int>
    let itPtr = unsafeBitCast(countPtr, to: UnsafePointer<Int>.self)

    
}


func testFuncTime(f: ()->()) -> CFTimeInterval {
    
    let start = CFAbsoluteTimeGetCurrent()
    f()
    return CFAbsoluteTimeGetCurrent() - start
    
}




/// Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
