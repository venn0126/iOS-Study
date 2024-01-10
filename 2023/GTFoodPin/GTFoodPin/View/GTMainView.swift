//
//  GTMainView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2024/1/10.
//

import Foundation
import SwiftUI

struct GTMainView: View {
    
    @State private var selectedTabIndex = 0
    
    var body: some View {
        
        TabView(selection: $selectedTabIndex,
                content:  {
            RestaurantListView()
                .tabItem {
                    Label("Favorites", systemImage: "tag.fill")
                }
                .tag(0)
            Text("Discover")
                .tabItem {
                    Label("Discover", systemImage: "wand.and.rays")
                }
                .tag(1)
            Text("About")
                .tabItem {
                    Label("About", systemImage: "square.stack")
                }
                .tag(2)
        })
        .tint(Color("NavigationBarTitle"))
    }
}




#Preview {
    GTMainView()
}

