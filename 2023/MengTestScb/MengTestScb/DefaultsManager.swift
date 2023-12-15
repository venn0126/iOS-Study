//
//  DefaultsManager.swift
//  MengTestScb
//
//  Created by Augus Venn on 2023/12/12.
//

import Foundation

class DefaultsManager {
    
    var defaults = UserDefaults.standard
    
    static var shared: DefaultsManager {
        get {
            return DefaultsManager()
        }
    }
    
   var mengRootFlag: Bool {
        get {
            defaults.bool(forKey: "mengRootFlag")
        }
        set {
            defaults.set(newValue, forKey: "mengRootFlag")
        }
    }
    
    
    
    
    
}
