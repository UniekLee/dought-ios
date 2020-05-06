//
//  BakeStepCell.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakeStepCell: View {
    let step: BakeStep
    let start: Date
    var onEdit: (() -> Void)?
    
    var body: some View {
        HStack {
            Text(step.name)
            Spacer()
            VStack(alignment: .trailing) {
                Text("+ " + step.durationString).foregroundColor(.secondary)
                Text(TimeCalculator.formatted(startTime: start))
            }
        }
        .padding([.top, .bottom], 10)
        .background(
            Group {
                if onEdit != nil {
                    Button(action: onEdit!) { EmptyView() }
                }
            }
        )
    }
}

fileprivate extension BakeStep {
    var durationString: String {
        return (try? TimeCalculator.formatted(duration: duration)) ?? ""
    }
}

struct BakeStepCell_Previews: PreviewProvider {
    static var previews: some View {
        return BakeStepCell(step: BakeStep(name: "Levain build", duration: 75),
                            start: Date(),
                            onEdit: {})
    }
}
