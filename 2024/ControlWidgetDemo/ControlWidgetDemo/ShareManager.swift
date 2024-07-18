//
//  ShareManager.swift
//  ControlWidgetDemo
//
//  Created by Augus Venn on 2024/7/18.
//

import Foundation

class ShareManager {
    static let shared = ShareManager()
    
    /// control toggle
    var isTurnedOn: Bool = false
    
    /// control button
    var caffineInTake: Double = 0.0
}
