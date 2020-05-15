//
//  DurationPicker.swift
//  Dought
//
//  Created by Lee Watkins on 06/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct DurationPicker: View {
    @Environment(\.presentationMode) var mode
    
    let title: String
    @State var currentDuration: Minutes
    let onCommit: (Minutes) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DurationPickerView(duration: $currentDuration)
                }.frame(minHeight: 200)
                Section {
                    FormSaveButton() {
                        self.onCommit(self.currentDuration)
                    }
                }
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") { self.mode.wrappedValue.dismiss() })
        }
    }
}

struct DurationPicker_Previews: PreviewProvider {
    static var previews: some View {
        DurationPicker(title: "Duration ⏰",
                       currentDuration: 74,
                       onCommit: { _ in })
    }
}
