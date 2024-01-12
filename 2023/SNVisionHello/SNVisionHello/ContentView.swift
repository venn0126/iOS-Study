//
//  ContentView.swift
//  SNVisionHello
//
//  Created by Augus Venn on 2023/12/21.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    var body: some View {
        
        SkyView()
    }
}


struct SkyView: View {
    var body: some View {
        HStack {
            SNSnow()
            SNRain()
        }
    }
}

#Preview(windowStyle: .automatic) {
    SkyView()

}
