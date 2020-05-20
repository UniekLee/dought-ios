//
//  StepRow.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct StepRow: View {
    let time: String
    let name: String
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            RowTimeTemplate(time)
            Text(name)
                .font(.body)
        }
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
                .overlay(Text(value).font(.subheadline),
                         alignment: .trailing)
        }
    }
}

struct StepRow_Previews: PreviewProvider {
    static var previews: some View {
        StepRow(time: "09:00", name: "Greet")
    }
}
