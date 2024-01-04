//
//  ContentView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2023/12/21.
//

import SwiftUI




struct RestaurantListView: View {
    
      
//    var restaurantImages = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
//    
//    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
//    
//    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
//    "New York", "New York", "New York", "New York", "New York", "New York", "New York", "London", "London", "London", "London"]
//    
//    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian/ Causual Drink", "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood", "American", "American", "Breakfast & Brunch", "Coffee &Tea", "Coffee & Tea", "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
//    
//    @State var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    @State private var showNewResaurant = false
    
    /*
    @State var restaurants = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location:
                    "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", phone: "348-233423", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Cafe Deadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", phone: "348-233424", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image:"Homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", phone: "348-233425", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", phone: "348-233426", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Cafe Loisl", isFavorite: false),
        
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong"
                   , phone: "348-233427", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Petite Oyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "HongKong", phone: "348-233428", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "For Kee Restaurant", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", phone: "348-233429", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Po's Atelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location:"Sydney", phone: "348-233435", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Bourke Street Bakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", phone: "348-233445", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Haigh's Chocolate", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", phone: "348-233455", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Palomino Espresso", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", phone: "348-233465", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", phone: "348-233475", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", phone: "348-233485", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Graham Avenue Meats And Deli", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "NewYork", phone: "348-233495", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Waffle & Wolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", phone: "348-233405", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Five Leaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", phone: "348-233525", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Cafe Lore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York"
                   , phone: "348-233625", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", phone: "348-233725", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", phone: "348-233825", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", phone: "348-233925", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "Royal Oak", isFavorite: false),
        
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", phone: "348-233025", description: "Searching for great breakfast eateries and coffee? This place is for you. We open at 6:30 every morning, and close at9 PM. We offer espresso and espresso based drink, such as capuccino, cafe latte, piccolo and many more. Come over and enjoy a great meal.", image: "CASK Pub and Kitchen", isFavorite: false)
    ]
    */
    
    @FetchRequest(entity: Restaurant.entity(), sortDescriptors: [])
    var restaurants: FetchedResults<Restaurant>
    
    @Environment(\.managedObjectContext) var context
    

    var body: some View {
        
        NavigationView {
            List {
                if restaurants.count == 0 {
                    Image("emptydata")
                        .resizable()
                        .scaledToFit()
                } else {
                    ForEach(restaurants.indices, id: \.self){ index in
                        
                        ZStack(alignment: .leading) {
                            NavigationLink(destination: RestaurantDetailView(restaurant: restaurants[index])) {
                                EmptyView()
                            }.opacity(0)
                            
                            BasicTextImageRow(restaurant: restaurants[index])

                        }
                    }
                    .onDelete(perform: deleteRecord)

                    .swipeActions(edge: .leading, allowsFullSwipe: false, content: {
                        Button {
                            
                        } label: {
                            Image(systemName: "heart")
                        }
                        .tint(.green)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .tint(.orange)
                    })
                    
                    .listRowSeparator(.hidden)
                }

            }
            // Navigation configure
            .listStyle(.plain)
            .navigationTitle("GTFoodPin")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                Button(action: {
                    self.showNewResaurant = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
        .accentColor(.primary)
        .sheet(isPresented: $showNewResaurant) {
            NewRestaurantView()
        }
       
    }
    
    
    private func deleteRecord(indexSet: IndexSet) {
        for index in indexSet {
            let itemToDelete = restaurants[index]
            context.delete(itemToDelete)
        }
        
        Task {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
}


// MARK: Subviews

struct FullImageRow: View {
    
    
    // MARK: - State variables
    @State private var showOptions = false
    @State private var showError = false
    
    // MARK: - Binding
    @ObservedObject var restaurant: Restaurant
        
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(uiImage: UIImage(data: restaurant.image) ?? UIImage())
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
        .confirmationDialog("What do you want to do", isPresented: $showOptions, titleVisibility: .visible, actions: {
            Button("Reserve a table") {self.showError.toggle()}
            Button("Mark as favorite") {self.restaurant.isFavorite.toggle()}
            Button("Cancel", role: .cancel) { }
        })
        
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"), message: Text("Sorry, this feature is not available yet. Please retry later."), primaryButton: .default(Text("OK")), secondaryButton: .cancel())
        }
    }
}


struct BasicTextImageRow: View {
    @State private var showOptions = false
    @State private var showError = false
  
    @ObservedObject var restaurant: Restaurant


    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(uiImage: UIImage(data: restaurant.image) ?? UIImage())
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
        
        // tap and hold
        .contextMenu {
            Button(action: {
                self.showError.toggle()
            }, label: {
                HStack {
                    Text("Reverse a table")
                    Image(systemName: "phone")
                }
            })
            
            Button(action: {
                self.restaurant.isFavorite.toggle()
            }, label: {
                HStack {
                    Text(self.restaurant.isFavorite ? "Remove from favorites " : "Mark a favorite")
                    Image(systemName: "heart")
                }
            })
            
            Button(action: {
                self.showOptions.toggle()
            }, label: {
                HStack {
                    Text("Share")
                    Image(systemName: "square.and.arrow.up")
                }
            })
        }
        
        
        .alert(isPresented: $showError){
            Alert(title: Text("Not yet available"), message: Text("Sorry, this feature is not available yet. Please retry later."), primaryButton: .default(Text("OK")), secondaryButton: .cancel())
        }
        
        .sheet(isPresented: $showOptions) {
            let defaultText = "Just checking in at \(restaurant.name)"
            if let imageToShare = UIImage(data: restaurant.image) {
                ActivityView(activityItems: [defaultText, imageToShare])
            } else {
                ActivityView(activityItems: [defaultText])
            }
        }
    }
}


// MARK: Prview

#Preview {
    
    RestaurantListView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//        .preferredColorScheme(.dark)
    // test dynamic type
//        .environment(\.dynamicTypeSize, .medium)
    
//    BasicTextImageRow(restaurant: (PersistenceController.testData?.first)!)
    
}
