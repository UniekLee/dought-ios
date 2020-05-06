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
        BakeStep(name: "Levain build", duration: 0),
        BakeStep(name: "Autolyse", duration: 3*60),
        BakeStep(name: "Mix", duration: 1*60),
        BakeStep(name: "Stretch & fold #1", duration: 30),
        BakeStep(name: "Stretch & fold #2", duration: 30),
//        BakeStep(name: "Stretch & fold #3", duration: 30),
//        BakeStep(name: "Pre shape", duration: Int(1.5*60)),
//        BakeStep(name: "Shape", duration: 30),
//        BakeStep(name: "Retard", duration: 30),
//        BakeStep(name: "Preheat oven", duration: 15*60),
        BakeStep(name: "Bake covered", duration: 1*60),
        BakeStep(name: "Bake uncovered", duration: 20),
        BakeStep(name: "Cool", duration: 30),
    ]
}
