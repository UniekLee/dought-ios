//
//  ActiveBakeView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI
import Combine

class ActiveBakeView_ViewModel: ObservableObject {
    @Published var bake: Bake
    @Published var selectedStage: Schedule.Stage
    @Published var stagesList_VM: StagesList_ViewModel
    @Published var stepsTitle: String
    @Published var stepsList_VM: StepsList_ViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(bake: Bake) {
        self.bake = bake
        let selected = bake.activeStage
        self.selectedStage = selected
        self.stagesList_VM = StagesList_ViewModel(stages: bake.schedule.stages,
                                                  selected: bake.activeStage)
        self.stepsTitle = "\(selected.kind.title) steps"
        self.stepsList_VM = StepsList_ViewModel(isActiveStage: true,
                                                steps: selected.steps)
        
        stagesList_VM.$selectedStage
            .map(\.self)
            .assign(to: \.selectedStage, on: self)
            .store(in: &cancellables)
        
        $selectedStage
            .map({ selected in
                StepsList_ViewModel(isActiveStage: selected == bake.activeStage,
                                    steps: selected.steps)
            })
            .assign(to: \.stepsList_VM, on: self)
            .store(in: &cancellables)
        
        $selectedStage
            .map({ selected in
                "\(selected.kind.title) steps"
            })
            .assign(to: \.stepsTitle, on: self)
            .store(in: &cancellables)
    }
    
    func select(stage: Schedule.Stage) {
        selectedStage = stage
    }
}

struct ActiveBakeView: View {
    @ObservedObject private var vm: ActiveBakeView_ViewModel
    
    @State private var isCancelling: Bool = false
    var onCancel: () -> Void
    
    init(bake: Bake, onCancel: @escaping () -> Void) {
        self.vm = ActiveBakeView_ViewModel(bake: bake)
        self.onCancel = onCancel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Stages")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                StagesList(vm: vm.stagesList_VM)
            }
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading) {
                    Text(vm.stepsTitle)
                        .font(.title)
                        .fontWeight(.bold)
                    Text(vm.bake.date(of: vm.selectedStage))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                StepsList(vm: vm.stepsList_VM)
            }
            Spacer()
        }
        .navigationBarTitle(Text(vm.bake.schedule.name),
                            displayMode: .inline)
        .navigationBarItems(trailing: Button("Cancel bake") {
            self.isCancelling.toggle()
        })
        .alert(isPresented: $isCancelling) {
            Alert(
                title: Text("Cancel this bake?"),
                message: Text("Are you sure that you want to cancel this bake?"),
                primaryButton: .destructive(Text("Cancel bake")) { self.onCancel() },
                secondaryButton: .cancel(Text("Continue bake"))
            )
        }
    }
}

struct ActiveBakeView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveBakeView(bake: .devMock()) {}
    }
}
