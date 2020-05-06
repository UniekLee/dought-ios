//
//  ContentView.swift
//  Dought
//
//  Created by Lee Watkins on 24/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var bake: Bake = Bake(steps: BakeStep.devData)
    
    var body: some View {
        NavigationView {
            BakeView(bake: $bake)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().accentColor(.orange)
    }
}
