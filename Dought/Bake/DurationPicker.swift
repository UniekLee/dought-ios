//
//  DurationPicker.swift
//  Dought
//
//  Created by Lee Watkins on 06/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct DurationPicker: View {
    @State private var hours: Int = 0
    @State private var minutes: Int = 15
    
    let title: String
    let currentDuration: Minutes
    let onCommit: (Minutes) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Stepper(value: $hours) {
                        HStack {
                            Text("Hours")
                            Spacer()
                            Text("\(hours)")
                                .foregroundColor(.secondary)
                        }
                    }
                    Stepper(value: $minutes) {
                        HStack {
                            Text("Minutes")
                            Spacer()
                            Text("\(minutes)")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                Section {
                    FormSaveButton() {
                        self.onCommit(self.selectedDuration)
                    }
                }
            }
            .navigationBarTitle(title)
        }.onAppear() {
            self.hours = self.currentDuration / 60
            self.minutes = self.currentDuration % 60
        }
    }
    
    private var selectedDuration: Minutes {
        return (hours * 60) + minutes
    }
}

struct DurationPicker_Previews: PreviewProvider {
    static var previews: some View {
        DurationPicker(title: "Duration ⏰",
                       currentDuration: 74,
                       onCommit: { _ in })
    }
}
