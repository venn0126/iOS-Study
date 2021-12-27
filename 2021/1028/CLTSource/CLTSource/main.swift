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

struct Augus: Codable {
    var name: String
    var age: Int
}

let jsonString = """
{
    "name" : "Augus",
    "age" : 18,
}
"""

let jsonData = jsonString.data(using: .utf8)
let decoder = JSONDecoder()
if let jsonData = jsonData,
   let result = try? decoder.decode(Augus.self, from: jsonData) {
    print(result)
} else {
    print("decode error")
}

print("decode end")

