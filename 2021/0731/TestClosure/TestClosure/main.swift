//
//  main.swift
//  TestClosure
//
//  Created by Augus on 2021/7/31.
//

import Foundation

// print("hello vscode")
// struct Cat {
//     var name: String = "niu"
//     var age: Int = 19
// }
// let aCat = Cat()
// print(aCat.age)

//var num: [Int] = [1,2,3]
//let numCopy = num
//print(num.count)

//enum Fruits {
//    case apple
//    case banana
//    case peach
//}
//
//extension Fruits: CaseIterable {
//
//
//}
//
//let allFruits = Fruits.allCases
//allFruits.forEach {
//    print($0)
//}

//enum Fruits {
//    case apple(Int)
//    case banana(Int, Double)
//    case peach(String, Double, Int)
//}
//
//let f = Fruits.peach("taozi", 12.18, 2021)

//enum Fruits {
//    case apple
//    case banana
//    case peach
//}
//
//print("size: \(MemoryLayout<Fruits>.size)")
//print("stride: \(MemoryLayout<Fruits>.stride)")
//print("alignment: \(MemoryLayout<Fruits>.alignment)")



//enum Fruits: String {
//    case apple
//    case banana
//    case peach
//}

//enum Fruits {
//    case apple(Int)
//    case banana(Int, Double)
//    case peach(String, Double, Int)
//}
//
//print("size: \(MemoryLayout<Fruits>.size)")
//print("stride: \(MemoryLayout<Fruits>.stride)")
//print("alignment: \(MemoryLayout<Fruits>.alignment)")
//
//var f = Fruits.peach("abc", 15, 12)
//withUnsafePointer(to: &f) {
//    print($0)
//}
//print("end")


// MARK: indirect key words demo


//indirect enum List<T> {
//  case end(T)
//  case node(T, next: List<T>)
//}

//var node = List.node("abc", next: List.end)
//withUnsafePointer(to: &node) {
//    print($0)
//}



//enum List<T> {
//  case end(T)
//  indirect case node(T, next: List<T>)
//}



indirect enum List<T> {
  case end(T)
  case node(T, next: List<T>)
}

print("size: \(MemoryLayout<List<String>>.size)")
print("stride: \(MemoryLayout<List<String>>.stride)")
print("alignment: \(MemoryLayout<List<String>>.alignment)")




