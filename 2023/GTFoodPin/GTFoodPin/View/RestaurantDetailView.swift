//
//  RestaurantDetailView.swift
//  GTFoodPin
//
//  Created by Augus on 2023/12/25.
//

import SwiftUI


struct RestaurantDetailView: View {
    
    
    @Environment(\.dismiss) var dismiss
    
    var restaurant: Restaurant
    
    var body: some View {
        
        ZStack(alignment: .top) {
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(minWidth: 0, maxWidth: .infinity)
            .ignoresSafeArea()
            
            Color.black
                .frame(height: 100)
                .opacity(0.8)
                .cornerRadius(20)
                .padding()
                .overlay {
                    VStack(spacing: 5) {
                        Text(restaurant.name)
                        Text(restaurant.type)
                        Text(restaurant.location)
                    }
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.white)
                }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("\(Image(systemName: "chevron.left")) \(restaurant.name)")
                })
            }
        }
    }
}



#Preview {
    
    RestaurantDetailView(restaurant:  Restaurant(name: "Cafe Deadend", type: "Cafe", location: "Hong Kong",  phone: "348-233425", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Cafe Deadend", isFavorite: true))
//        .preferredColorScheme(.dark)
    
}
