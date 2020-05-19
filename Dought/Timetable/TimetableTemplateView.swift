//
//  TimetableTemplateView.swift
//  Dought
//
//  Created by Lee Watkins on 19/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct BakeStage: Identifiable {
    let id: UUID = UUID()
    
    let accentColor: Color
    let day: String
    let name: String
    
    let steps: [BakeStage.Step]

    struct Step: Identifiable {
        let id: UUID = UUID()
        
        let time: String
        let name: String
    }
}

struct BakeStageCard: View {
    let stage: BakeStage
    
    var body: some View {
        Group {
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
            .cornerRadius(3)
            .shadow(radius: 7)
        }
        .padding()
        .accentColor(stage.accentColor)
        .listRowBackground(Color.secondary)
    }
}

struct StageHeaderRow: View {
    let day: String
    let name: String
    let addStepAction: () -> Void
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            RowTimeTemplate(day)
            Text(name)
                .font(.title)
                .fontWeight(.bold)
                .fixedSize(horizontal: false, vertical: true)
            Spacer()
            Button(action: addStepAction) {
                Image(systemName: "plus.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding([.top, .leading, .trailing], 10)
            }
            .foregroundColor(.accentColor)
            .frame(width: 44, height: 44, alignment: .bottom)
        }
    }
}

struct StepRow: View {
    let time: String
    let name: String
    
    var body: some View {
        HStack {
            RowTimeTemplate(time)
            Text(name)
                .font(.body)
        }
    }
}

struct RowTimeTemplate: View {
    let value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    var body: some View {
        Group {
            Text("00:00")
                .font(.subheadline)
                .hidden()
                .overlay(Text(value).font(.subheadline),
                         alignment: .trailing)
        }
    }
}

struct TimetableTemplateView: View {
    let stages: [BakeStage] = BakeStage.devData()
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(spacing: 0) {
                ForEach(stages) { stage in
                    BakeStageCard(stage: stage)
                }
            }
        }
        .navigationBarTitle("Weekend bake")
    }
}

struct TimetableTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        TimetableTemplateView()
    }
}

struct TimetableTemplateView_NavStacked_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimetableTemplateView()
        }
    }
}

struct TimetableTemplateView_DarkMode_Previews: PreviewProvider {
    static var previews: some View {
        TimetableTemplateView().environment(\.colorScheme, .dark)
    }
}

struct TimetableTemplateView_LargeText_Previews: PreviewProvider {
    static var previews: some View {
        TimetableTemplateView().environment(\.sizeCategory, .accessibilityExtraExtraExtraLarge)
    }
}

extension BakeStage {
    static func devData() -> [BakeStage] {
        return [
            BakeStage(accentColor: .blue,
                      day: "Day 1",
                      name: "Levain build",
                      steps: [
                        BakeStage.Step(time: "09:00", name: "Add levain"),
                        BakeStage.Step(time: "11:00", name: "Autolyse"),
                ]
            ),
            BakeStage(accentColor: .green,
                      day: "Day 1",
                      name: "Mix & Bulk Ferment",
                      steps: [
                        BakeStage.Step(time: "12:00", name: "Mix levain"),
                        BakeStage.Step(time: "12:30", name: "Mix salt"),
                        BakeStage.Step(time: "13:00", name: "Stretch & Fold #1"),
                        BakeStage.Step(time: "13:30", name: "Stretch & Fold #2"),
                        BakeStage.Step(time: "14:00", name: "Stretch & Fold #3"),
                ]
            ),
            BakeStage(accentColor: .yellow,
                      day: "Day 1",
                      name: "Shape",
                      steps: [
                        BakeStage.Step(time: "17:00", name: "Pre-shape"),
                        BakeStage.Step(time: "17:30", name: "Shape"),
                ]
            ),
            BakeStage(accentColor: .orange,
                      day: "Day 1",
                      name: "Proof",
                      steps: [
                        BakeStage.Step(time: "18:00", name: "Refrigerate"),
                ]
            ),
            BakeStage(accentColor: .red,
                      day: "Day 2",
                      name: "Bake",
                      steps: [
                        BakeStage.Step(time: "08:00", name: "Preheat oven"),
                        BakeStage.Step(time: "09:00", name: "Bake covered"),
                        BakeStage.Step(time: "09:20", name: "Uncover"),
                        BakeStage.Step(time: "09:45", name: "Remove & cool"),
                ]
            ),
        ]
    }
}
