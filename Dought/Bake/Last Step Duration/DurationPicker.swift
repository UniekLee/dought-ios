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
    
    @State private var hours: Int = 0
    @State private var minutes: Int = 15
    
    let title: String
    let currentDuration: Minutes
    let onCommit: (Minutes) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    GeometryReader { geom in
                        HStack {
                            HStack {
                                Picker("", selection: self.$hours) {
                                    ForEach(Range(0...24)) { Text("\($0)") }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(maxWidth: geom.size.width/4)
                                .clipped()
                                Text(self.hoursSuffix)
                                Spacer()
                            }
                            .frame(width: geom.size.width/2)
                            
                            HStack {
                                Picker("", selection: self.$minutes) {
                                    ForEach(Range(0...60)) { Text("\($0)") }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .frame(maxWidth: geom.size.width/4)
                                .clipped()
                                Text(self.minutesSuffix)
                                Spacer()
                            }
                            .frame(width: geom.size.width/2)
                        }
                    }
                }.frame(minHeight: 200)
                Section {
                    FormSaveButton() {
                        self.onCommit(self.selectedDuration)
                    }
                }
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") { self.mode.wrappedValue.dismiss() })
        }
        .onAppear() {
            self.hours = self.currentDuration / 60
            self.minutes = self.currentDuration % 60
        }
    }
    
    private var selectedDuration: Minutes {
        return (hours * 60) + minutes
    }
    
    private func pluralSuffix(for number: Int) -> String {
        if number != 1 {
            return "s"
        } else {
            return ""
        }
    }
    
    private var minutesSuffix: String {
        "minute" + pluralSuffix(for: minutes)
    }
    
    private var hoursSuffix: String {
        "hour" + pluralSuffix(for: hours)
    }
}

struct DurationPicker_Previews: PreviewProvider {
    static var previews: some View {
        DurationPicker(title: "Duration ⏰",
                       currentDuration: 74,
                       onCommit: { _ in })
    }
}
