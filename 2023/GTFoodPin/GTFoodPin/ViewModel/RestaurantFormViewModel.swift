//
//  RestaurantFormViewModel.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2024/1/3.
//

import Foundation
import Combine
import UIKit

class RestaurantFormViewModel: ObservableObject {
    
    // input
    /// Published 指明这个值是双向可变的
    @Published var name: String = ""
    @Published var type: String = ""
    @Published var location: String = ""
    @Published var phone: String = ""
    @Published var description: String = ""
    @Published var image: UIImage = UIImage()
    
    init(restaurant: Restaurant? = nil) {
        if let restaurant = restaurant {
            self.name = restaurant.name
            self.type = restaurant.type
            self.location = restaurant.location
            self.phone = restaurant.phone
            self.description = restaurant.summary
            self.image = UIImage(data: restaurant.image) ?? UIImage()
        }
    }
}
