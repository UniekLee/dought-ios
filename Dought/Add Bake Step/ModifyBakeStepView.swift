//
//  ModifyBakeStepView.swift
//  Dought
//
//  Created by Lee Watkins on 30/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ModifyBakeStepView: View {
    @Environment(\.presentationMode) var mode
    
    @State private var isEdit: Bool = false

    @State var step: BakeStep = .makeNew()
    var onCommit: (BakeStep) -> Void = { _ in }

    private var title: String {
        if isEdit {
            return "Edit \"\(step.name)\" step"
        } else {
            return "New bake step"
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    LabeledTextField(label: "Name",
                                     placeHolder: "Bulk fermentation",
                                     text: $step.name)
                    HStack(alignment: .bottom) {
                        LabeledTextField(label: "Duration",
                                         placeHolder: "15",
                                         text: Binding(
                                            get: { self.durationAsString },
                                            set: { self.step.duration = Int($0) ?? 0 })
                        )
                            .keyboardType(.numberPad)
                        Text("minutes")
                    }
                }
                Section {
                    FormSaveButton() {
                        self.onCommit(self.step)
                    }
                }
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarItems(leading: CancelButton(screenPresentation: self.mode))
            .onAppear {
                self.isEdit = self.step.isValid
            }
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
        ModifyBakeStepView(step: .makeNew()) { _ in }
    }
}
