//
//  StageHeaderRow.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct StageHeaderRow: View {
    let day: String
    let name: String
    let addStepAction: () -> Void
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            RowTimeTemplate(day)
            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Button(action: addStepAction) {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .leading, .trailing], 10)
            }
            .foregroundColor(.accentColor)
            .frame(width: 44, height: 44, alignment: .bottom)
        }
    }
}

struct StageHeaderRow_Previews: PreviewProvider {
    static var previews: some View {
        StageHeaderRow(day: "Day 1", name: "Mix & Bulk", addStepAction: {})
    }
}
