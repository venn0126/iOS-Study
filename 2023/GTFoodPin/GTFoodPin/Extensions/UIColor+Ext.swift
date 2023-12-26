//
//  UIColor+Ext.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2023/12/26.
//

import Foundation
import UIKit
import SwiftUI

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
}


// MARK: Custom Color
extension Color {
    
    static let NavigationBarTitle = Color("NavigationBarTitle")


}
