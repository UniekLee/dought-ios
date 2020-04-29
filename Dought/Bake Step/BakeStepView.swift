//
//  BakeStepView.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakeStepView: View {
    @Binding var step: BakeStep
    
    var body: some View {
        HStack {
            Text(step.name)
            Spacer()
            Text("\(step.duration) minutes")
        }
        .padding()
    }
}

struct BakeStepView_Previews: PreviewProvider {
    static var previews: some View {
        return BakeStepView(step: .constant(BakeStep(name: "Levain build", duration: 75)))
    }
}
