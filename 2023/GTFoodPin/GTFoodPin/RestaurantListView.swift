//
//  ContentView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2023/12/21.
//

import SwiftUI




struct RestaurantListView: View {
    
    @State var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    
    var restaurantImages = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
    "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
    
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee &Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    
    @State var restaurants = [ 
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location:
                    "Hong Kong", image: "Cafe Deadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image:
                    "Homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "Teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "Cafe loisl", isFavorite: false),
        
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong"
                   , image: "Petite Oyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong", image: "For Kee Restaurant", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong"
                   , image: "Po's Atelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:
                    "Sydney", image: "Bourke Street Backery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney"
                   , image: "Haigh's Chocolate", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "Palomino Espresso", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "Upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "Traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "Graham Avenue Meats", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", image: "Waffle & Wolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "Five Leaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "Cafe Lore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York"
                   , image: "Confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "Barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "Donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "Royal Oak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "CASK Pub and Kitchen", isFavorite: false)]
    
    

    var body: some View {
        
        List {
            ForEach(restaurantNames.indices, id: \.self){ index in
                
                BasicTextImageRow(restaurant: $restaurants[index])
            }
            .listRowSeparator(.hidden)

        }.listStyle(.plain)

    }
    
}


// MARK: Subviews

struct FullImageRow: View {
    
    @State private var showOptions = false
    @State private var showError = false
    
    @Binding var restaurant: Restaurant
        
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Image(restaurant.image)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .cornerRadius(20)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(restaurant.name)
                        .font(.system(.title2, design: .rounded))
                    if restaurant.isFavorite {
                        Spacer()
                        Image(systemName: "heart.fill")
                            .foregroundColor(.yellow)
                    }
                }
             
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions){
            ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [
                .default(Text("Reserve a table")){
                    self.showError.toggle()
                },
                .default(Text("Mark as favorite")){
                    self.restaurant.isFavorite.toggle()
                },
                .cancel()
            ])
        }
        
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"), message: Text("Sorry, this feature is not available yet. Please retry later."), primaryButton: .default(Text("OK")), secondaryButton: .cancel())
        }
    }
}


struct BasicTextImageRow: View {
    @State private var showOptions = false
    @State private var showError = false
  
    @Binding var restaurant: Restaurant


    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(restaurant.image)
                .resizable()
                .frame(width: 120, height: 118)
                .clipShape(RoundedRectangle(cornerRadius: 20.0))
            
            
            VStack(alignment: .leading) {
                Text(restaurant.name)
                    .font(.system(.title2, design: .rounded))
                Text(restaurant.type)
                    .font(.system(.body, design: .rounded))
                Text(restaurant.location)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
                
            }
            
            
            if restaurant.isFavorite {
                Spacer()
                Image(systemName: "heart.fill")
                    .foregroundColor(.yellow)
            }
        }
        .onTapGesture {
            showOptions.toggle()
        }
        .actionSheet(isPresented: $showOptions){
            ActionSheet(title: Text("What do you want to do"), message: nil, buttons: [
                .default(Text("Reserve a table")){
                    self.showError.toggle()
                },
                .default(Text("Mark as favorite")){
                    self.restaurant.isFavorite.toggle()
                },
                .cancel()
            ])
        }
        
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"), message: Text("Sorry, this feature is not available yet. Please retry later."), primaryButton: .default(Text("OK")), secondaryButton: .cancel())
        }
    }
}


// MARK: Prview

#Preview {
    
    RestaurantListView()
//        .preferredColorScheme(.dark)
    
}
