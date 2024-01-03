//
//  NewRestaurantView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2023/12/26.
//

import Foundation
import SwiftUI

struct NewRestaurantView: View {
    
    
    enum PhotoSource: Identifiable {
        case photoLibrary
        case camera
        
        var id: Int {
            hashValue
        }
    }
    
    
    init(){
        let viewModel = RestaurantFormViewModel()
        viewModel.image = UIImage(named: "newphoto")!
        restaurantFormViewModel = viewModel
    }
    
    
    @State var restaurantName = ""
    
//    @State private var resturantImage = UIImage(named: "newphoto")!
    
    @State private var showPhotoOptions = false
    
    @State private var photoSource: PhotoSource?
    
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.managedObjectContext) var context
    
    /*
     SwiftUI 为我们提供了 @ObservedObject 属性包装器，它可以订阅可观察对象，并在可观察对象发生变化时更新视图。通过使用 @ObservedObject 对 restaurantFormViewModel 进行包装，我们可以监控其值的变化。它与 @State 非常相似，但 @ObservedObject 是专为使用 ObservableObject 而设计的
     */
    @ObservedObject private var  restaurantFormViewModel: RestaurantFormViewModel
    
    var body: some View {
        
        
        
        NavigationView  {
            
            ScrollView {
                
                Image(uiImage: restaurantFormViewModel.image)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 200)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .padding(.bottom)
                    .onTapGesture {
                        self.showPhotoOptions.toggle()
                    }
                    
                VStack {
                    FormTextField(label: "Name", placeholder: "Fill in the restaurant name", value: $restaurantFormViewModel.name)
                    FormTextField(label: "Type", placeholder: "Fill in the restaurant type", value: $restaurantFormViewModel.type)
                    FormTextField(label: "ADDRESS", placeholder: "Fill in the restaurant address", value: $restaurantFormViewModel.location)
                    FormTextField(label: "PHONE", placeholder: "Fill in the restaurant phone", value: $restaurantFormViewModel.phone)
                    FormTextView(label: "Description", value: $restaurantFormViewModel.description, height: 100)
                }
                .padding()
            }
            
            // Navigation bar configuration
            .navigationTitle("New Restaurant")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
               
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                    })
                    .accentColor(.primary)
                    
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
               
                    Button(action: {
                        save()
                        dismiss()
                    }, label: {
                        Text("Save")
                            .font(.headline)
                            .foregroundColor(Color.NavigationBarTitle)
                    })
                }
            }
        }
        
        .confirmationDialog("Choose your photo source", isPresented: $showPhotoOptions, titleVisibility: .visible, actions: {
            Button("Camera") {self.photoSource = .camera}
            Button("Photo Library") {self.photoSource = .photoLibrary}
            Button("Cancel", role: .cancel) { }
        })
        .fullScreenCover(item: $photoSource) { source in
            switch source {
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $restaurantFormViewModel.image).ignoresSafeArea()
            case .camera:ImagePicker(sourceType: .camera, selectedImage: $restaurantFormViewModel.image).ignoresSafeArea()
            }
        }
    }
    
    
    private func save() {
        let restaurant = Restaurant(context: context)
        restaurant.name = restaurantFormViewModel.name
        restaurant.type = restaurantFormViewModel.type
        restaurant.location = restaurantFormViewModel.location
        restaurant.phone = restaurantFormViewModel.phone
        restaurant.image = restaurantFormViewModel.image.pngData()!
        restaurant.summary = restaurantFormViewModel.description
        restaurant.isFavorite = false
        
        do {
            try context.save()
        } catch {
            print("NewRestaurantView Failed to save the record error \(error.localizedDescription)")
            
        }
    }
}


struct FormTextField: View {
    
    let label: String
    var placeholder: String = ""
    
    @Binding var value: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            
            TextField(placeholder, text: $value)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                .textFieldStyle(PlainTextFieldStyle())
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                    
                }
            .padding(.vertical, 10)
        }
    }
}


struct FormTextView: View {
    
    let label: String
    
    @Binding var value: String
    var height: CGFloat = 200.0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label.uppercased())
                .font(.system(.headline, design: .rounded))
                .foregroundColor(Color(.darkGray))
            
            TextEditor(text: $value)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .padding(10)
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color(.systemGray5), lineWidth: 1)
                    
                }
            .padding(.vertical, 10)
        }
    }
}


#Preview {
    NewRestaurantView()

}
