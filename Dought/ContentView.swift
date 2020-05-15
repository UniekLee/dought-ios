//
//  ContentView.swift
//  Dought
//
//  Created by Lee Watkins on 24/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var bakeVM: BakeViewModel = BakeViewModel(bakeRepository: LocalBakeRepository())
    
    var body: some View {
        NavigationView {
            BakeView(bakeVM: bakeVM)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
