//
//  LocalBakeRepository.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import Disk

class LocalBakeRepository: BaseBakeRespository, BakeRepository, ObservableObject {
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
        if let retrievedBake = try? Disk.retrieve("bake.json", from: .documents, as: Bake.self) {
            self.bake = retrievedBake
        } else {
            self.bake.steps = BaseBakeRespository.bakeTemplate
        }
    }
    
    private func saveData() {
        do {
            try Disk.save(self.bake, to: .documents, as: "bake.json")
        }
        catch let error as NSError {
            fatalError("""
                Domain: \(error.domain)
                Code: \(error.code)
                Description: \(error.localizedDescription)
                Failure Reason: \(error.localizedFailureReason ?? "")
                Suggestions: \(error.localizedRecoverySuggestion ?? "")
                """)
        }
    }
}

