//
//  main.swift
//  CLTSource
//
//  Created by Augus on 2021/12/12.
//

import Foundation

//var num: Array<Int> = [1, 2, 3]
//var num: Array<Int> = [1, 2, 3]
//withUnsafePointer(to: &num) {
//    print($0)
//}
//print("end")

//var num: Array<Int> = [1, 2, 3]
//withUnsafePointer(to: &num) {
//    print($0)
//}
//var copyNum = num
//num.append(4)
//print("end")


//var dict = ["1" : "Dog","2" : "Cat","3" : "fish","4" : "bird"]
//withUnsafePointer(to: &dict) {
//    print($0)
//}
//print("end")





//enum Fruits: Int {
//    case apple = 11
//    case banana = 24
//    case peach = 8
//}
//
//var f = Fruits.peach
//withUnsafePointer(to: &f) {
//    print($0)
//}
//print("end")

//enum Fruits: Int {
//    case apple = 11
//    case banana = 24
//    case peach = 8
//
//
//    var rawValue: Int {
//        switch self {
//        case .apple:
//            return 11
//        case .banana:
//            return 24
//        case .peach:
//            return 9
//        }
//    }
//
//    init?(rawValue: Int) {
//        if rawValue == 10 {
//            self = .apple
//        } else if rawValue == 24 {
//            self = .banana
//        } else if rawValue == 8 {
//            self = .peach
//        } else {
//            return nil
//        }
//    }
//
//}
//
//let p = Fruits.peach.rawValue
//print(p)
//print("end")


//MARK: - Test Codable

//struct Augus: Codable {
//    var name: String
//    var age: Int
//}
//
//let jsonString = """
//{
//    "name" : "Augus",
//    "age" : 18,
//}
//"""
//
//let jsonData = jsonString.data(using: .utf8)
//let decoder = JSONDecoder()
//if let jsonData = jsonData,
//   let result = try? decoder.decode(Augus.self, from: jsonData) {
//    print(result)
//} else {
//    print("decode error")
//}
//
//print("decode end")


//MARK: - KeyedDecodingContainer Demo
//struct Augus: Codable {
//    var name: String
//    var age: Int
//
//    enum CodingKeys: CodingKeys {
//        case name
//        case age
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        age = try container.decode(Int.self, forKey: .age)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//        try container.encode(age, forKey: .age)
//    }
//}
//
//let jsonString = """
//{
//    "name" : "augus",
//    "age" : 17,
//}
//"""
//let jsonData = jsonString.data(using: .utf8)
//let decoder = JSONDecoder()
//if let jsonData = jsonData, let result = try? decoder.decode(Augus.self, from: jsonData) {
//    print(result)
//} else {
//    print("decode data error")
//}


//MARK: - UnKeyedDecodingContainer Demo
//struct Rectangle: Codable {
//
//    var width: Double
//    var height: Double
//
//    init(from decoder: Decoder) throws {
//        var container = decoder.unkeyedContainer()
//        width = try container.decode(Double.self)
//        height = try container.decode(Double.self)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.unkeyedContainer()
//        try container.encode(width)
//        try container.encode(height)
//    }
//}

//MARK: - SingValueDecodingContainer

//struct AugusStringDouble: Codable {
//
//    var someString: String
//    var someDouble: Double
//
//    init(from decoder: Decoder) throws {
//        let container = decoder.singleValueContainer()
//        if let stringValue = try? container.decode(String.self)
//            someString = stringValue
//            someDouble = Double(stringValue) ?? 0
//    } else if let doubleValue = try? container.decode(Double.self) {
//        someDouble = doubleValue
//        someString = String(doubleValue)
//    } else {
//        someString = ""
//        someDouble = 0
//    }
//}

//struct Augus: Codable {
//
//    private var _isPoor: Bool?
//    var isPoor: Bool {
//        guard let _isPoor = _isPoor else {
//            return false
//        }
//        return _isPoor
//    }
//}

//struct Augus: Codable {
//
//    var name: String?
//    var age: Int?
//
//}
//
//
//extension Optional where Wrapped == String {
//    var value: String {
//        switch self {
//        case .some:
//            return self!
//        case .none:
//            return ""
//        }
//    }
//}

protocol DefaultValue {
    static var defaultValue: Self { get }
}

extension String: DefaultValue {
    static let defaultValue: String = ""
}

extension Int: DefaultValue {
    static let defaultValue: Int = 0
}

typealias DefaultCodable = DefaultValue & Codable

@propertyWrapper
struct Default<T: DefaultCodable> {
    var wrappedValue: T
}

extension Default: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = (try? container.decode(T.self)) ?? T.defaultValue
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

extension KeyedDecodingContainer {
    
    func decode<T>(_ type: Default<T>.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Default<T> where T: DefaultCodable {
        try decodeIfPresent(type, forKey: key) ?? Default(wrappedValue: T.defaultValue)
    }
}

extension UnkeyedDecodingContainer {
    mutating func decode<T>(_ type: Default<T>.Type) throws -> Default<T> where T: DefaultCodable {
        try decodeIfPresent(type) ?? Default(wrappedValue: T.defaultValue)
    }
}

struct Augus: Codable {
    @Default var name: String
    @Default var age: Int
}

let jsonString = """
{
    "name" : "gao",
}
"""

let jsonData = jsonString.data(using: .utf8)
let decoder = JSONDecoder()
if let jsonData = jsonData, let result = try? decoder.decode(Augus.self, from: jsonData) {
    print(result)
    print("name is \(result.name)")
    print("age is \(result.age)")
} else {
    print("decode data error")
}

