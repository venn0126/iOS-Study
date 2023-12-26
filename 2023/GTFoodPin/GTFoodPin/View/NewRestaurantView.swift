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
    
    
    @State var restaurantName = ""
    
    @State private var resturantImage = UIImage(named: "newphoto")!
    
    @State private var showPhotoOptions = false
    
    @State private var photoSource: PhotoSource?
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        
        
        NavigationView  {
            
            ScrollView {
                
                Image(uiImage: resturantImage)
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
                    FormTextField(label: "Name", placeholder: "Fill in the restaurant name", value: .constant(""))
                    FormTextField(label: "Type", placeholder: "Fill in the restaurant type", value: .constant(""))
                    FormTextField(label: "ADDRESS", placeholder: "Fill in the restaurant address", value: .constant(""))
                    FormTextField(label: "PHONE", placeholder: "Fill in the restaurant phone", value: .constant(""))
                    FormTextView(label: "Description", value: .constant(""), height: 100)
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
               
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(Color.NavigationBarTitle)
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
            case .photoLibrary: ImagePicker(sourceType: .photoLibrary, selectedImage: $resturantImage).ignoresSafeArea()
            case .camera:ImagePicker(sourceType: .camera, selectedImage: $resturantImage).ignoresSafeArea()
            }
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
