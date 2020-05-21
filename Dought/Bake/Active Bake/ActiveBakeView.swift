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
    
    init(bake: Bake) {
        guard let firstStage = bake.schedule.stages.first else {
            fatalError("Cannot start a bake with no stages")
        }
        _bake = State(initialValue: bake)
        _selectedStage = State(initialValue: firstStage)
    }
    
    var body: some View {
        VStack(spacing: 32) {
            VStack(alignment: .leading) {
                Text("Stages")
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(bake.schedule.stages) { stage in
                                    Button(action: {
                                        self.selectedStage = stage
                                    }) {
                                        Text(stage.kind.title)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                            .padding()
                                            .background(stage.accent.color)
                                            .cornerRadius(.infinity)
                                    }
                        }
                    }
                }
            }
            VStack(alignment: .leading) {
                Text("\(selectedStage.kind.title) steps")
                    .font(.title)
                    .fontWeight(.bold)
                Text(bake.date(of: selectedStage))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                List {
                    ForEach(selectedStage.steps) { step in
                        // TODO: Calculate the date!
                        StepRow(start: step.startTime,
                                name: step.name)
                    }
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(bake.schedule.name)
    }
}

struct ActiveBakeView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveBakeView(bake: .devMock())
    }
}
