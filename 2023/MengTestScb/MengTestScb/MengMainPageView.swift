//
//  MengMainPageView.swift
//  MengTestScb
//
//  Created by Augus on 2023/9/14.
//

import SwiftUI

struct MengMainPageView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        NavigationView {
            VStack {
                Text(MengStrings.logInSuccessfully).padding()
                Button(action: {
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text(MengStrings.logout).padding()
                })
            }
        }.navigationBarHidden(true)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MengMainPageView()
    }
}
