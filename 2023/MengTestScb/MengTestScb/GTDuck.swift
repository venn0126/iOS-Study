//
//  GTDuck.swift
//  MengTestScb
//
//  Created by Augus Venn on 2023/12/28.
//

import Foundation

class GTDuck {
    
    var duckType: String
    var name: String
    var owner: String = "Owner"
    
    
    init(duckType: String, name: String) {
        self.duckType = duckType
        self.name = name
    }
    
    class func run() {
        print("run")
    }
    
    func printDuckType() {
        print("Your duck type is \(self.duckType)")
    }
    
    func changeOwner(newOwner: String) {
        self.owner = newOwner
    }
    
    func isDuckAtHitb(duckName name: String) -> Bool {
        if name == "Augus" {
            return false
        } else {
            return true
        }
    }
}
