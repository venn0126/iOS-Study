//
//  SNRain.swift
//  SNVisionHello
//
//  Created by Augus Venn on 2023/12/21.
//

import Foundation


import SwiftUI
import RealityKit
import RealityKitContent

struct SNRain: View {
    var body: some View {
        Model3D(named: "Rain", bundle: realityKitContentBundle) { phase in
            switch phase {
            case .empty:
                Text("Waiting...")
            case .success(let resolvedModel3D):
                resolvedModel3D
                    .resizable()
                    .scaleEffect(CGSize(width: 0.5, height: 0.5))
            case .failure(let error):
                Text(error.localizedDescription)
            @unknown default:
                fatalError()
            }
        }
    }
}

#Preview {
    SNRain()
}
