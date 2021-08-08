//: A UIKit based Playground for presenting user interface
  

import Foundation

let p = UnsafeMutableRawPointer.allocate(byteCount: 4 * 8, alignment: 8)
defer {
    p.deallocate()
}

for i in 0..<4 {
    p.advanced(by: i * 8).storeBytes(of: i, as: Int.self)
}
let offset = 8 * 4
print(p.advanced(by: offset).load(as: Int.self))

class Document {
    
    var name: String?
    
    init() {}
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

class AutoDoc: Document {
    
//    override init() {
//        super.init()
//        self.name = "[Untitled]"
//    }
    
    override init() {
        super.init(name: "[Untitled]")!
    }
    
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[untitled]"
        } else {
            self.name = name
        }
    }
}

