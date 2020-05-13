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
    func updateEndTime(_ endTime: Date)
    func updateLastStepDuration(_ duration: Minutes)
}

class TestDataBakeRepository: BaseBakeRespository, BakeRepository, ObservableObject {
    override init() {
        super.init()
        loadData()
    }
    
    // MARK: - Step modifiers    
    func addStep(_ step: BakeStep) {
        bake.steps.append(step)
        saveData()
    }
    
    func removeStep(_ step: BakeStep) {
        if let index = bake.steps.firstIndex(where: { $0.id == step.id }) {
            bake.steps.remove(at: index)
            saveData()
        }
    }
    
    func updateStep(_ step: BakeStep) {
        if let index = bake.steps.firstIndex(where: { $0.id == step.id }) {
            bake.steps[index] = step
            saveData()
        }
    }
    
    func moveStep(from source: IndexSet, to destination: Int) {
        bake.steps.move(fromOffsets: source, toOffset: destination)
        saveData()
    }
    
    // MARK: - Time modifiers
    func updateStartTime(_ startTime: Date) {
        bake.startTime = startTime
        saveData()
    }
    
    func updateEndTime(_ endTime: Date) {
        bake.endTime = endTime
        saveData()
    }
    
    func updateLastStepDuration(_ duration: Minutes) {
        bake.finalStepDuration = duration
        saveData()
    }
    
    private func loadData() {
        bake.steps = BakeStep.devData
    }
    
    private func saveData() {
        // TODO
    }
}
