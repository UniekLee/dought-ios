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
    @State private var isEdditingStartDelay: Bool = false

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
                }
                Section {
                    HStack {
                        Text("After previous step, wait")
                        Spacer()
                        // TODO: Move to viewModel
                        Text((try? TimeCalculator.formatted(duration: step.startDelay)) ?? "")
                            .foregroundColor(.secondary)
                    }.background(
                        Button(action: { self.isEdditingStartDelay.toggle() }) {
                            EmptyView()
                        }
                    )
                    
                    if isEdditingStartDelay {
                        DurationPickerView(duration: $step.startDelay).frame(height: 200)
                    }
                }
                Section {
                    FormSaveButton() {
                        self.onCommit(self.step)
                    }
                }
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") { self.mode.wrappedValue.dismiss() })
            .onAppear {
                self.isEdit = self.step.isValid
            }
        }
    }
    
    private var durationAsString: String {
        if step.startDelay == 0 {
            return ""
        } else {
            return "\(step.startDelay)"
        }
    }
    
    private var durationPicker: some View {
        DurationPickerView(duration: $step.startDelay)
    }
}

extension BakeStep {
    var isValid: Bool {
        return !name.isEmpty && startDelay > 0
    }
}

struct ModifyBakeStepView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyBakeStepView(step: .makeNew()) { _ in }
    }
}
