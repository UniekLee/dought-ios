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
    
    var body: some View {
        HStack {
            Text(step.name)
            Spacer()
            Text("\(step.duration) minutes")
        }
        .padding([.top, .bottom], 10)
    }
}

struct BakeStepCell_Previews: PreviewProvider {
    static var previews: some View {
        return BakeStepCell(step: BakeStep(name: "Levain build", duration: 75))
    }
}
