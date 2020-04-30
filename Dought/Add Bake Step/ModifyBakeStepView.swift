//
//  ModifyBakeStepView.swift
//  Dought
//
//  Created by Lee Watkins on 30/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ModifyBakeStepView: View {
    @State private var step: BakeStep = .makeNew()
    var onCommit: (Result<BakeStep, Never>) -> Void = { _ in }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $step.name)
                HStack {
                    TextField("Duration", text: Binding(
                        get: { self.durationAsString },
                        set: { self.step.duration = Int($0) ?? 0 })
                    )
                    .keyboardType(.numberPad)
                    Text("minutes")
                }
            }
            .navigationBarTitle("Modify step")
            .navigationBarItems(trailing:
                Button(action: {
                    self.onCommit(.success(self.step))
                }) {
                    Text("Save")
                }
                    .disabled(!step.isValid)
            )
        }
    }
    
    private var durationAsString: String {
        if step.duration == 0 {
            return ""
        } else {
            return "\(step.duration)"
        }
    }
}

extension BakeStep {
    var isValid: Bool {
        return !name.isEmpty && duration > 0
    }
}

struct ModifyBakeStepView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyBakeStepView() { _ in }
    }
}
