//
//  BakeViewModel.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import Combine

class BakeViewModel: ObservableObject {
    @Published var bakeRepository: BakeRepository
    
    @Published var startTime: String = ""
    @Published var bakeStepCellViewModels = [BakeStep]()
    @Published var lastStepDuration: String = ""
    @Published var endTime: String = ""
    
    // TODO: Move in to End Time VM
    @Published var endTimeDate: Date = Date()
    
    @Published private var bakeDuration: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init(bakeRepository: BakeRepository) {
        self.bakeRepository = bakeRepository
        
        bakeRepository.bake.$startTime
            .map({ TimeCalculator.formatted(startTime:$0) })
            .assign(to: \.startTime, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$steps
            .assign(to: \.bakeStepCellViewModels, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$steps
            .map({
                $0.map(\.duration)
                    .reduce(bakeRepository.bake.finalStepDuration) { $0 + $1 }
            })
            .assign(to: \.bakeDuration, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$finalStepDuration
            .compactMap({ try? TimeCalculator.formatted(duration: $0) })
            .assign(to: \.lastStepDuration, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$finalStepDuration
            .map({
                bakeRepository.bake.steps
                    .map(\.duration)
                    .reduce($0) { $0 + $1 }
            })
            .assign(to: \.bakeDuration, on: self)
            .store(in: &cancellables)
        
        // Recalculating end times
        
        bakeRepository.bake.$startTime.map({
            TimeCalculator.add(self.bakeDuration, to: $0)
        })
            .assign(to: \.endTimeDate, on: self)
            .store(in: &cancellables)
        
        $bakeDuration.map({
            TimeCalculator.add($0, to: bakeRepository.bake.startTime)
        })
            .assign(to: \.endTimeDate, on: self)
            .store(in: &cancellables)
        
        $endTimeDate
            .map({ TimeCalculator.formatted(startTime: $0) })
            .assign(to: \.endTime, on: self)
            .store(in: &cancellables)
    }
    
    // MARK: - Step modifiers
    func addOrUpdate(step: BakeStep) {
        if bakeStepCellViewModels.contains(where: { $0.id == step.id }) {
            bakeRepository.updateStep(step)
        } else {
            bakeRepository.addStep(step)
        }
    }
    
    func removeSteps(at offsets: IndexSet) {
        let steps = offsets.lazy.map { self.bakeStepCellViewModels[$0] }
        steps.forEach { bakeStepCellViewModel in
          bakeRepository.removeStep(bakeStepCellViewModel)
        }
    }
    
    func moveStep(from source: IndexSet, to destination: Int) {
        bakeRepository.moveStep(from: source, to: destination)
    }
    
    // MARK: - Time modifiers
    func updateStartTime(_ startTime: Date) {
        bakeRepository.updateStartTime(startTime)
    }
    
    func updateEndTime(_ endTime: Date) {
        let negativeBakeDuration = -1 * bakeDuration
        if let newStartTime = Calendar.current.date(byAdding: .minute,
                                                  value: negativeBakeDuration,
                                                  to: endTime) {
            bakeRepository.updateStartTime(newStartTime)
        }
    }
    
    func updateLastStepDuration(_ duration: Minutes) {
        bakeRepository.updateLastStepDuration(duration)
    }
}
