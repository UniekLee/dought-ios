//
//  StepRow.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct StepRow: View {
    let start: Date
    let name: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            RowTimeTemplate(time)
            Text(name)
                .font(.body)
        }
    }
    
    private static let formatter: DateFormatter = {
        let date = DateFormatter()
        date.dateFormat = "HH:mm"
        return date
    }()
    
    var time: String {
        return StepRow.formatter.string(from: start)
    }
}

struct RowTimeTemplate: View {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    var body: some View {
        Group {
            Text("00:00")
                .font(.subheadline)
                .hidden()
                .overlay(
                    Text(value)
                        .font(.subheadline)
                        .foregroundColor(.secondary),
                    alignment: .trailing
            )
        }
    }
}

struct StepRow_Previews: PreviewProvider {
    static var previews: some View {
        StepRow(start: Date(), name: "Greet")
    }
}
