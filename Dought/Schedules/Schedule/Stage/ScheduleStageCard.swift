//
//  ScheduleStageCard.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

class ScheduleStageViewModel: ObservableObject {
//    @Published var day: String
}

struct ScheduleStageCard: View {
    let stage: Schedule.Stage
    let day: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Rectangle()
                .foregroundColor(.accentColor)
                .frame(width: 10)
            VStack(alignment: .leading, spacing: 10) {
                StageHeaderRow(day: "Day \(day)", name: stage.kind.title)
//                {
//                    // TODO
//                }
                ForEach(stage.steps) { step in
                    StepRow(start: step.startTime, name: step.name)
                }
            }
            .padding()
        }
        .background(Color("cardBackground"))
        .cornerRadius(5)
        .shadow(radius: 7)
        .padding()
        .accentColor(stage.accent.color)
    }
}

struct BakeStageCard_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleStageCard(stage: Schedule.Stage.devMock()[1], day: 1)
    }
}
