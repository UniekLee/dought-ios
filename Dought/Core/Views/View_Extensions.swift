//
//  View_Extensions.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}
