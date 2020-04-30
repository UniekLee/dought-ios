//
//  AppDefaults.swift
//  Dought
//
//  Created by Lee Watkins on 30/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct AppDefaults: ViewModifier {
    func body(content: Content) -> some View {
        content
            // defaults
            .accentColor(.orange)
    }
}
