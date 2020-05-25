//
//  StepsList.swift
//  Dought
//
//  Created by Lee Watkins on 25/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct StepsList: View {
    @Binding var steps: [Schedule.Stage.Step]
    
    var body: some View {
        List {
            ForEach(steps) { step in
                StepRow(start: step.startTime,
                        name: step.name)
            }
        }
    }
}

struct StepsList_Previews: PreviewProvider {
    static var previews: some View {
        StepsList(steps: .constant(Bake.devMock().schedule.stages[1].steps))
    }
}
