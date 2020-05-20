//
//  ScheduleStage.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import SwiftUI

struct ScheduleStage: Identifiable {
    let id: UUID = UUID()
    
    let accentColor: Color
    let day: String
    let name: String
    
    let steps: [ScheduleStage.Step]

    struct Step: Identifiable {
        let id: UUID = UUID()
        
        let time: String
        let name: String
    }
}

extension ScheduleStage {
    static func devData() -> [ScheduleStage] {
        return [
            ScheduleStage(accentColor: .blue,
                      day: "Day 1",
                      name: "Levain build",
                      steps: [
                        ScheduleStage.Step(time: "09:00", name: "Add levain"),
                        ScheduleStage.Step(time: "11:00", name: "Autolyse"),
                ]
            ),
            ScheduleStage(accentColor: .green,
                      day: "Day 1",
                      name: "Mix & Bulk Ferment",
                      steps: [
                        ScheduleStage.Step(time: "12:00", name: "Mix levain"),
                        ScheduleStage.Step(time: "12:30", name: "Mix salt"),
                        ScheduleStage.Step(time: "13:00", name: "Stretch & Fold #1"),
                        ScheduleStage.Step(time: "13:30", name: "Stretch & Fold #2"),
                        ScheduleStage.Step(time: "14:00", name: "Stretch & Fold #3"),
                ]
            ),
            ScheduleStage(accentColor: .yellow,
                      day: "Day 1",
                      name: "Shape",
                      steps: [
                        ScheduleStage.Step(time: "17:00", name: "Pre-shape"),
                        ScheduleStage.Step(time: "17:30", name: "Shape"),
                ]
            ),
            ScheduleStage(accentColor: .orange,
                      day: "Day 1",
                      name: "Proof",
                      steps: [
                        ScheduleStage.Step(time: "18:00", name: "Refrigerate"),
                ]
            ),
            ScheduleStage(accentColor: .red,
                      day: "Day 2",
                      name: "Bake",
                      steps: [
                        ScheduleStage.Step(time: "08:00", name: "Preheat oven"),
                        ScheduleStage.Step(time: "09:00", name: "Bake covered"),
                        ScheduleStage.Step(time: "09:20", name: "Uncover"),
                        ScheduleStage.Step(time: "09:45", name: "Remove & cool"),
                ]
            ),
        ]
    }
}

