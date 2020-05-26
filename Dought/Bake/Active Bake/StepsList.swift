//
//  StepsList.swift
//  Dought
//
//  Created by Lee Watkins on 25/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import Combine

class StepsList_ViewModel: ObservableObject {
    let isActiveStage: Bool
    @Published var steps: [Schedule.Stage.Step]
    @Published var nextStep: Schedule.Stage.Step?
    @Published var hasNextStep: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    init(isActiveStage: Bool, steps: [Schedule.Stage.Step]) {
        self.isActiveStage = isActiveStage
        self.steps = steps
        let nextStep = steps.first(where: { !$0.isComplete })
        self.nextStep = nextStep
        self.hasNextStep = nextStep != nil
        
        $steps.map({ steps in
            steps.first(where: { !$0.isComplete })
        })
            .assign(to: \.nextStep, on: self)
            .store(in: &cancellables)
        
        $nextStep.map({ possibleNextStep in
            possibleNextStep != nil
        })
            .assign(to: \.hasNextStep, on: self)
            .store(in: &cancellables)
    }
    
    func complete(step: Schedule.Stage.Step) {
        steps = steps.map(){
            if $0 == step {
                var mutableStep = $0
                mutableStep.isComplete = true
                return mutableStep
            } else {
                return $0
            }
        }
    }
    
    func isNext(step: Schedule.Stage.Step) -> Bool {
        if isActiveStage,
            let nextStep = nextStep,
            step == nextStep {
            return true
        } else {
            return false
        }
    }
    
    func icon(for step: Schedule.Stage.Step) -> AnyView {
        if step.isComplete {
            return Image(systemName: "checkmark.seal.fill")
                .foregroundColor(.accentColor)
                .eraseToAnyView()
        } else if isNext(step: step) {
            return Image("checkmark.seal")
                .foregroundColor(.secondary)
                .eraseToAnyView()
        } else {
            return EmptyView().eraseToAnyView()
        }
    }
}

struct StepsList: View {
    let vm: StepsList_ViewModel
    
    var body: some View {
        List {
            ForEach(vm.steps) { step in
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "checkmark.seal")
                            .hidden()
                            .overlay(
                                self.vm.icon(for: step)
                        )
                        StepRow(start: step.startTime,
                                name: step.name)
                        Spacer()
                    }
                    if self.vm.isNext(step: step) {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.vm.complete(step: step)
                            }) {
                                Text("Complete")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.accentColor)
                                    .cornerRadius(7)
                            }
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "bell.fill")
                                    .padding()
                                    .foregroundColor(.accentColor)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct StepsList_Previews: PreviewProvider {
    static var previews: some View {
        var steps = Bake.devMock().schedule.stages[1].steps
        steps[0].isComplete = true
        steps[1].isComplete = true
        let vm = StepsList_ViewModel(isActiveStage: true, steps: steps)
        return StepsList(vm: vm)
    }
}
