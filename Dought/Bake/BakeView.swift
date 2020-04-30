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
    @State private var isShowingEditModal: Bool = false
    
    var body: some View {
        VStack {
            List {
                ForEach(steps) { step in
                    BakeStepCell(step: step)
                }
                .onDelete(perform: remove)
                .onMove(perform: move)
            }
            Button(action: {
                self.isShowingEditModal = true
            }) {
              HStack {
                Image(systemName: "plus.circle.fill")
                  .resizable()
                  .frame(width: 20, height: 20)
                Text("Add step")
              }
            }
            .padding()
            .sheet(isPresented: $isShowingEditModal) {
                ModifyBakeStepView() { result in
                    guard case .success(let step) = result else { return }
                    self.add(step: step)
                    self.isShowingEditModal = false
                }
            }
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
    
    private func add(step: BakeStep) {
        steps.append(step)
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
