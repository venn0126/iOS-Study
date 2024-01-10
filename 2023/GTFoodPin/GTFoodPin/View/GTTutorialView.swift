//
//  GTTutorialView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2024/1/10.
//

import Foundation
import SwiftUI


struct GTTutorialView: View {
    
    let pageHeadings = ["CREATE YOUR OWN FOOD GUIDE", "SHOW YOU THE LOCATION"
                        , "DISCOVER GREAT RESTAURANTS" ]
    let pageSubHeads = [ "Pin your favorite restaurants and create your own food guide",
                         "Search and locate your favorite restaurant on Maps",
                        "Find restaurants shared by your friends and other"]
    
    let pageImages = ["onboarding-1", "onboarding-2", "onboarding-3"]
    
    @State private var currentPage = 0
    @Environment(\.dismiss) var dismiss
    @AppStorage("hasViewdWalkthrough") var hasViewedWalkthrough: Bool = false
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemIndigo
        UIPageControl.appearance().pageIndicatorTintColor = .lightGray
    }
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pageHeadings.count, id: \.self) { index in
                GTTutorialPage(image: pageImages[index], heading: pageHeadings[index], subHeading: pageSubHeads[index])
                    .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))
        .animation(.default, value: currentPage)
        
        VStack(spacing: 20) {
            Button(action: {
                if currentPage < pageHeadings.count - 1 {
                    currentPage += 1
                } else {
                    hasViewedWalkthrough = true
                    dismiss()
                }
            }, label: {
                
                Text(currentPage == pageHeadings.count - 1 ? "GET STARTED" : "NEXT")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .padding(.horizontal, 50)
                    .background(Color(.systemIndigo))
                    .clipShape(RoundedRectangle(cornerRadius: 25.0))
                
            })
            
            if currentPage < pageHeadings.count - 1 {
                Button(action: {
                    dismiss()
                    hasViewedWalkthrough = true
                }, label: {
                    Text("Skip")
                        .font(.headline)
                        .foregroundStyle(Color(.darkGray))
                })
            }
        }
        .padding(.bottom)
    }
}


struct GTTutorialPage: View {
    
    let image: String
    let heading: String
    let subHeading: String
        
    var body: some View {
        VStack(spacing: 70) {
            Image(image)
                .resizable()
                .scaledToFit()
            
            VStack(spacing: 10) {
                Text(heading)
                    .font(.headline)
                
                Text(subHeading)
                    .font(.body)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal, 40)
            Spacer()
        }
        .padding(.top)
    }
}


#Preview {
//    GTTutorialView(image: "onboarding-1", heading: "CREATE YOUR OWN FOOD GUIDE", subHeading: "Pin your favorite restaurants and create your own food guide")
    GTTutorialView()
        .previewLayout(.sizeThatFits)
}
