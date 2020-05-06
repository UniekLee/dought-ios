//
//  SetTimeView.swift
//  Dought
//
//  Created by Lee Watkins on 06/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct SetTimeView: View {
    var label: String
    @State var time: Date
    var onCommit: (Date) -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker(selection: $time,
                               displayedComponents: [.date, .hourAndMinute]) {
                                Text(label)
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button(action: {
                            self.onCommit(self.time)
                        }) {
                            HStack {
                                Image(systemName: "square.and.arrow.down")
                                Text("Save")
                            }
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Set time")
        }
    }
}

struct SetTimeView_Previews: PreviewProvider {
    static var previews: some View {
        SetTimeView(label: "Start", time: Date()) { _ in }
    }
}
