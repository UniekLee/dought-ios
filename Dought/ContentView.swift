//
//  ContentView.swift
//  Dought
//
//  Created by Lee Watkins on 24/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var steps: [BakeStep] = BakeStep.devData
    
    var body: some View {
        NavigationView {
            BakeView(steps: $steps)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
