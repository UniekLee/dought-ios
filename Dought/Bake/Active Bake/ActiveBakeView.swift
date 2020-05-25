//
//  ActiveBakeView.swift
//  Dought
//
//  Created by Lee Watkins on 21/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ActiveBakeView: View {
    @State private var bake: Bake
    @State private var selectedStage: Schedule.Stage
    @State private var isCancelling: Bool = false
    var onCancel: () -> Void
    
    init(bake: Bake, onCancel: @escaping () -> Void) {
        guard let firstStage = bake.schedule.stages.first else {
            fatalError("Cannot start a bake with no stages")
        }
        _bake = State(initialValue: bake)
        _selectedStage = State(initialValue: firstStage)
        self.onCancel = onCancel
    }
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Stages")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                StageList(stages: bake.schedule.stages) { stage in
                    self.selectedStage = stage
                }
            }
            VStack(alignment: .leading) {
                Text("\(selectedStage.kind.title) steps")
                    .font(.title)
                    .fontWeight(.bold)
                Text(bake.date(of: selectedStage))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                StepsList(steps: $selectedStage.steps)
            }
            .padding()
            Spacer()
        }
        .navigationBarTitle(Text(bake.schedule.name),
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

struct StageList: View {
    let stages: [Schedule.Stage]
    let onStageSelect: (Schedule.Stage) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Spacer()
                ForEach(stages) { stage in
                    Button(action: {
                        self.onStageSelect(stage)
                    }) {
                        Text(stage.kind.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding()
                            .background(stage.accent.color)
                            .cornerRadius(.infinity)
                    }
                }
                Spacer()
            }
        }
    }
}

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

struct ActiveBakeView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveBakeView(bake: .devMock()) {}
    }
}
