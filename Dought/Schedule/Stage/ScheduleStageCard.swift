//
//  ScheduleStageCard.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ScheduleStageCard: View {
    let stage: ScheduleStage
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.accentColor)
                .frame(width: 10)
            VStack(alignment: .leading, spacing: 10) {
                StageHeaderRow(day: stage.day, name: stage.name){}
                ForEach(stage.steps) { step in
                    StepRow(time: step.time, name: step.name)
                }
            }
            .padding([.leading, .trailing, .bottom])
        }
        .background(Color("cardBackground"))
        .cornerRadius(5)
        .shadow(radius: 7)
        .padding()
        .accentColor(stage.accentColor)
    }
}

struct BakeStageCard_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleStageCard(stage: ScheduleStage.devData()[1])
    }
}
