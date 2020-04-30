//
//  BakeStep.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

typealias Minutes = Int

struct BakeStep: Identifiable {
    let id: UUID = UUID()
    var name: String
    var duration: Minutes
}

extension BakeStep {
    static func makeNew() -> BakeStep {
        return BakeStep(name: "", duration: 0)
    }
}

extension BakeStep {
    static var devData: [BakeStep] = [
        BakeStep(name: "Levain build", duration: 300),
        BakeStep(name: "Autolyse", duration: 60),
        BakeStep(name: "Mix", duration: 15),
        BakeStep(name: "Bulk ferment", duration: 240),
        BakeStep(name: "Pre shape", duration: 5),
        BakeStep(name: "Rest", duration: 25),
        BakeStep(name: "Shape", duration: 10),
        BakeStep(name: "Rest", duration: 30),
        BakeStep(name: "Retard", duration: 960),
        BakeStep(name: "Bake covered", duration: 20),
        BakeStep(name: "Bake uncovered", duration: 20),
    ]
}
