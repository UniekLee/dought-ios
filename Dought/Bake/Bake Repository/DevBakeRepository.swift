//
//  DevBakeRepository.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

class DevBakeRepository: BaseBakeRespository, BakeRepository, ObservableObject {
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
        bake.steps = [
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
    
    private func saveData() {
        // TODO
    }
}
