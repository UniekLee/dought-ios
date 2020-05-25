//
//  StagesList.swift
//  Dought
//
//  Created by Lee Watkins on 25/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct StagesList: View {
    let stages: [Schedule.Stage]
    @Binding var selectedStage: Schedule.Stage
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                Spacer()
                ForEach(stages) { stage in
//                    VStack(spacing: 4) {
                    Button(action: {
                        withAnimation {
                            self.selectedStage = stage
                        }
                    }) {
                        Text(stage.kind.title)
                            .fontWeight(self.isSelected(stage: stage) ? .bold : .regular)
                            .foregroundColor(.white)
                            .padding()
                            .background(stage.accent.color)
                            .cornerRadius(.infinity)
                    }
                    .shadow(color: self.isSelected(stage: stage) ? .gray : .clear,
                            radius: 3,
                            x: 0,
                            y: 3)
                    .padding(.bottom, 7)
//                        .fixedSize(horizontal: true, vertical: false)
//                        if stage == self.selectedStage {
//                            Rectangle()
//                                .foregroundColor(.accentColor)
//                                .frame(height: 5)
//                        }
//                    }
                }
                Spacer()
            }
        }
    }
    
    private func isSelected(stage: Schedule.Stage) -> Bool {
        return stage == selectedStage
    }
}

struct StagesList_Previews: PreviewProvider {
    static var previews: some View {
        let stages = Bake.devMock().schedule.stages
        return StagesList(stages: stages,
                selectedStage: .constant(stages[1]))
    }
}

//struct StageButton: View {
//    let stage: Schedule.Stage
//    @Binding var selectedStage: Schedule.Stage
//
//    var body: some View {
//
//    }
//
//    var isShowingSelectedStage: Bool {
//        return stage == selectedStage
//    }
//}
