//
//  DummyControlBundle.swift
//  DummyControl
//
//  Created by Augus Venn on 2024/7/18.
//

import WidgetKit
import SwiftUI

@main
struct DummyControlBundle: WidgetBundle {
    var body: some Widget {
        DummyControl()
        DummyControlControl()
    }
}
