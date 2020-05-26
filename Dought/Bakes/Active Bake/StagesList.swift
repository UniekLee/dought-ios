//
//  StagesList.swift
//  Dought
//
//  Created by Lee Watkins on 25/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import Combine

class StagesList_ViewModel: ObservableObject {
    let stages: [Schedule.Stage]
    @Published var selectedStage: Schedule.Stage
    
    init(stages: [Schedule.Stage], selected: Schedule.Stage) {
        self.stages = stages
        self.selectedStage = selected
    }
}

struct StagesList: View {
    @ObservedObject var vm: StagesList_ViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                Spacer()
                ForEach(vm.stages) { stage in
//                    VStack(spacing: 4) {
                    Button(action: {
                        withAnimation {
                            self.vm.selectedStage = stage
                        }
                    }) {
                        Text(stage.kind.title)
                            .fontWeight(.semibold)
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
        return stage == vm.selectedStage
    }
}

struct StagesList_Previews: PreviewProvider {
    static var previews: some View {
        let stages = Bake.devMock().schedule.stages
        let vm = StagesList_ViewModel(stages: stages, selected: stages[1])
        return StagesList(vm: vm)
//            stages: stages,
//                selectedStage: .constant(stages[1]))
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
