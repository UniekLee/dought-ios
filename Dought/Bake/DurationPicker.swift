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
    
    var currentDuration: Minutes
    var onCommit: (Minutes) -> Void
    
    var body: some View {
        NavigationView {
//            GeometryReader { geometry in
//                HStack {
//                    Picker("Hours", selection: self.$hours) {
//                        ForEach(0..<24) {
//                            Text("\($0)")
//                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    .frame(maxWidth: geometry.size.width / 4)
//                    .clipped()
//
//                    Picker("Minutes", selection: self.$minutes) {
//                        ForEach(0..<60) {
//                            Text("\($0)")
//                        }
//                    }
//                    .pickerStyle(WheelPickerStyle())
//                    .frame(maxWidth: geometry.size.width / 4)
//                    .clipped()
//                }.labelsHidden()
//            }
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
            .navigationBarTitle("Duration")
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
        DurationPicker(currentDuration: 74, onCommit: { _ in })
    }
}
