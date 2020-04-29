//
//  BakeView.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakeView: View {
    @Binding var steps: [BakeStep]
    
    var body: some View {
        List {
            ForEach(steps) { step in
                BakeStepView(step: step)
            }
            .onDelete(perform: remove)
            .onMove(perform: move)
        }
        .navigationBarTitle("Bake")
        .navigationBarItems(trailing: EditButton())
    }
    
    private func remove(at offsets: IndexSet) {
        steps.remove(atOffsets: offsets)
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        steps.move(fromOffsets: source, toOffset: destination)
    }
}

struct BakeView_Previews: PreviewProvider {
    static var previews: some View {
        WrapperView()
    }
}

fileprivate struct WrapperView: View {
    @State private var steps: [BakeStep] = BakeStep.devData
    
    var body: some View {
        BakeView(steps: $steps)
    }
}
