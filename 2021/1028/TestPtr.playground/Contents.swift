//: A UIKit based Playground for presenting user interface
  
import PlaygroundSupport
import Foundation

// on 64-bit
MemoryLayout<Int>.size
MemoryLayout<Int>.alignment
MemoryLayout<Int>.stride

MemoryLayout<Int8>.size
MemoryLayout<Int8>.alignment
MemoryLayout<Int8>.stride

MemoryLayout<Int16>.size
MemoryLayout<Int16>.alignment
MemoryLayout<Int16>.stride

MemoryLayout<Int32>.size
MemoryLayout<Int32>.alignment
MemoryLayout<Int32>.stride

MemoryLayout<Int64>.size
MemoryLayout<Int64>.alignment
MemoryLayout<Int64>.stride

MemoryLayout<Bool>.size
MemoryLayout<Bool>.alignment
MemoryLayout<Bool>.stride

MemoryLayout<Float>.size
MemoryLayout<Float>.alignment
MemoryLayout<Float>.stride

MemoryLayout<Double>.size
MemoryLayout<Double>.alignment
MemoryLayout<Double>.stride


// Alignment demo
// 申请一块内存区域，大小为4字节 * 8位，对齐方式为8
let ptr = UnsafeMutableRawPointer.allocate(byteCount: 4 * 8, alignment: 8)
// 结束时释放空间
defer {
    ptr.deallocate()
}
// 在这个区域内存储，0，1，2，3
for i in 0..<4 {
    ptr.advanced(by: i * 8).storeBytes(of: i, as: Int.self)
}
let offset = 8
print(ptr.advanced(by: offset).load(as: Int.self))


// Struct Memory Layout
struct EmptyStruct {}
MemoryLayout<EmptyStruct>.size      // 0
MemoryLayout<EmptyStruct>.alignment // 1
MemoryLayout<EmptyStruct>.stride    // 1

struct AugusStruct {
    let height: Double
    let flag: Bool
}
MemoryLayout<AugusStruct>.size      // 9
MemoryLayout<AugusStruct>.alignment // 8
MemoryLayout<AugusStruct>.stride    // 16


// Class Memory Layout(on 64-bit)
class EmptyClass {}
MemoryLayout<EmptyClass>.size      // 8
MemoryLayout<EmptyClass>.alignment // 8
MemoryLayout<EmptyClass>.stride    // 8

class AugusClass {
    let height: Double = 0
    let flag: Bool = false
}
MemoryLayout<AugusClass>.size      // 8
MemoryLayout<AugusClass>.alignment // 8
MemoryLayout<AugusClass>.stride    // 8


// UnsafeMutableRawPointer store and load two Int numbers

// 1
let count = 2
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = count * stride

// 2
do {
    print("Raw pointers")
    
    // 3
    let ptr = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    
    // 4
    defer {
        ptr.deallocate()
    }
    
    // 5
    ptr.storeBytes(of: 24, as: Int.self)
    ptr.advanced(by: stride).storeBytes(of: 3, as: Int.self)
    ptr.load(as: Int.self)
    ptr.advanced(by: stride).load(as: Int.self)
    
    // 6
    let bufferPointer = UnsafeRawBufferPointer(start: ptr, count: byteCount)
    for (index, byte) in bufferPointer.enumerated() {
        print("byte \(index): \(byte)")
    }
}

// UnsafeMutablePointer

do {
    print("Typed pointers")
    // 向堆申请为大小为count，数据类型Int的内存空间，
    let ptr = UnsafeMutablePointer<Int>.allocate(capacity: count)
    // 进行内存空间的初始化
    ptr.initialize(repeating: 0, count: count)
    // 作用域结束执行
    defer {
        // 释放申请的内存空间
        ptr.deallocate()
    }
    
    // 存储第一个数据
    ptr.pointee = 24
    // 存储第二个数据
    ptr.advanced(by: 1).pointee = 3
    // 加载第一个数据
    ptr.pointee
    // 加载第二个数据
    ptr.advanced(by: 1).pointee
    
    // UnsafeBufferPointer向UnsafeMutablePointer的转化
    let bufferPtr = UnsafeBufferPointer(start: ptr, count: count)
    // 遍历指针所指向的内存的位置所对应的数据
    // buffer byte: 0 : 24
    // buffer byte: 1 : 3
    for (index, byte) in bufferPtr.enumerated() {
        print("buffer byte: \(index) : \(byte)")
    }
}

// Convert Raw Pointers to Typed Pointers

do {
    
    print("Convert Raw Pointers to Typed Pointers")
    // 通过字节量和对齐方式进行堆内存空间的申请
    let rawPtr = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    // 作用域结束执行
    defer {
        // 释放申请的内存空间
        rawPtr.deallocate()
    }
    // 通过类型和字节量原始类型绑定为泛类型的指针
    let typedPtr = rawPtr.bindMemory(to: Int.self, capacity: count)
    // 泛型指针的初始化
    typedPtr.initialize(repeating: 0, count: count)
    // 作用域结束执行
    defer {
        // 释放泛型指针的内存空间
        typedPtr.deinitialize(count: count)
    }

    // 泛型指针存储第一个数据24
    typedPtr.pointee = 24
    // 泛型指针存储第二个数据3
    typedPtr.advanced(by: 1).pointee = 3
    // 泛型指针读取第一个数据24
    typedPtr.pointee
    // 泛型指针读取第二个数据3
    typedPtr.advanced(by: 1).pointee
    
    // UnsafeBufferPointer使用泛型指针初和字节量初始化
    let bufferPtr = UnsafeBufferPointer(start: typedPtr, count: count)
    // 遍历泛型集合指针的存储位置对应的数据
    /*
     convert value: 0: 24
     convert value: 1: 3
     */
    for (index, value) in bufferPtr.enumerated() {
        print("convert value: \(index): \(value)")
    }
    
}


// Struct to pointer
do {
    struct AugusStudent {
        var age = 18
        var name = "Augus"
    }
    
    var stu = AugusStudent()
    withUnsafePointer(to: &stu) { ptr in
        // let ptr: UnsafePointer<AugusStudent>
        // name: Augus, age: 18
        // pointee：读这个指针所引用的实例
        print("name: \(ptr.pointee.name), age: \(ptr.pointee.age)")
    }
    
    withUnsafeMutablePointer(to: &stu) { ptr in
        // let ptr: UnsafeMutablePointer<AugusStudent>
        // pointee：写这个指针所引用的实例
        ptr.pointee.name = "Tian"
        ptr.pointee.age = 17
        // 2 name: Tian, age: 17
        print("2 name: \(ptr.pointee.name), age: \(ptr.pointee.age)")
    }
    
    withUnsafeBytes(of: stu) { ptr in
        // let ptr: UnsafeRawBufferPointer<AugusStudent>
        // 3 ptr count: 24
        print("3 ptr count: \(ptr.count)")
        // 3 age: 17, name: Tian
        print("3 age: \(ptr.load(as: Int.self)), name: \(ptr.load(fromByteOffset: MemoryLayout<Int>.stride, as: String.self))")
    }
    
    withUnsafeMutableBytes(of: &stu) { ptr in
        // let ptr: UnsafeMutableRawBufferPointer<AugusStudent>
        ptr.storeBytes(of: 19, as: Int.self)
        ptr.storeBytes(of: "Gao", toByteOffset: MemoryLayout<Int>.stride, as: String.self)
        // 4 ptr count: 24
        print("4 ptr count: \(ptr.count)")
        // 4 age: 19, name: Gao
        print("4 age: \(ptr.load(as: Int.self)), name: \(ptr.load(fromByteOffset: MemoryLayout<Int>.stride, as: String.self))")
    }
}


// Class to pointer
// 我们知道类是引用类型，本身是一个指针，这就变成了转换成我们需要的类型指针的问题
// 我们可以转化为`UnsafeRawPointer`指针，从Swfit源码中我们可以知道类的大概结构，所以我们可以将类转化为`UnsafePointer<HeapObject>`

do {
    
    struct HeapObject {
        var kind: Int
        var unknowedRef: Int32
        var strongRef: Int32
    }
    
    class AugusClass {
        var name = "Augus"
    }
    
    // 多次声明常量使`strongRef`增加
    // HeapObject(kind: 4340074368, unknowedRef: 3, strongRef: 0)
    let c = AugusClass()
    // HeapObject(kind: 4332537728, unknowedRef: 3, strongRef: 2)
    let c1 = c
    // HeapObject(kind: 4403840912, unknowedRef: 3, strongRef: 4)
    let c2 = c1
    // 使用Unmanaged获取指针，let ptr: UnsafeMutableRawPointer
    let ptr = Unmanaged.passUnretained(c2).toOpaque()
    print(ptr.assumingMemoryBound(to: HeapObject.self).pointee)
    
    // 直接强转，在这里我们确定结构一致
    // HeapObject(kind: 4379363224, unknowedRef: 3, strongRef: 4)
    let ptr1 = unsafeBitCast(c, to: UnsafePointer<HeapObject>.self)
    print(ptr1.pointee)
    
    
}


func log(format: String!, withParameters valist: CVaListPointer) {
    NSLogv(format, valist)
}

let args: [CVarArg] = [ "foo", 12, 34.56 ]
withVaList(args) {
    log(format: "%@ %ld %f", withParameters: $0)
}

