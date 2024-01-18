//
//  ViewExtension.swift
//  GTSwiftUITest
//
//  Created by Augus Venn on 2024/1/17.
//

import Foundation
import SwiftUI


extension View {
  @ViewBuilder
  func applyIf<V: View>(_ condition: Bool? = true, transform: (Self) -> V) -> some View {
      
      if let c = condition {
          if c {
            transform(self)
          } else {
              self
          }
      } else {
          self
      }
      
//    if condition {
//      transform(self)
//    } else {
//      self
//    }
  }
}
