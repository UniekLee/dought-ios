//
//  BakeStage.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
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

