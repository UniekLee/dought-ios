//
//  BakeRepository.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

class BaseBakeRespository {
    @Published var bake: Bake = Bake()
}

protocol BakeRepository: BaseBakeRespository {
    // Step modifiers
    func addStep(_ step: BakeStep)
    func removeStep(_ step: BakeStep)
    func updateStep(_ step: BakeStep)
    func moveStep(from source: IndexSet, to destination: Int)
    
    // Time modifiers
    func updateStartTime(_ startTime: Date)
    func updateLastStepDuration(_ duration: Minutes)
}

extension BaseBakeRespository {
    static let bakeTemplate: [BakeStep] = [
        BakeStep(name: "Levain build", duration: 0),
        BakeStep(name: "Autolyse", duration: 3*60),
        BakeStep(name: "Mix", duration: 1*60),
        BakeStep(name: "Stretch & fold #1", duration: 30),
        BakeStep(name: "Stretch & fold #2", duration: 30),
        BakeStep(name: "Stretch & fold #3", duration: 30),
        BakeStep(name: "Pre shape", duration: Int(1.5*60)),
        BakeStep(name: "Shape", duration: 30),
        BakeStep(name: "Retard", duration: 30),
        BakeStep(name: "Preheat oven", duration: 15*60),
        BakeStep(name: "Bake covered", duration: 1*60),
        BakeStep(name: "Bake uncovered", duration: 20),
        BakeStep(name: "Cool", duration: 30),
    ]
}
