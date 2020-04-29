//
//  BakeStepView.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakeStepView: View {
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

struct BakeStepView_Previews: PreviewProvider {
    static var previews: some View {
        return BakeStepView(step: BakeStep(name: "Levain build", duration: 75))
    }
}
