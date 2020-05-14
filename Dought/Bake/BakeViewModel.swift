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
    @Published var bakeStepCellViewModels = [BakeStepCellViewModel]()
    @Published var lastStepDuration: String = ""
    @Published var endTime: String = ""
    
    // TODO: Move in to End Time VM
    @Published var endTimeDate: Date = Date()
    
    @Published private var bakeDuration: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    
    init(bakeRepository: BakeRepository) {
        self.bakeRepository = bakeRepository
        
        setUpBindings()
    }
    
    func setUpBindings() {
        bakeRepository.bake.$startTime
            .map({ TimeCalculator.formatted(startTime:$0) })
            .assign(to: \.startTime, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$startTime
            .map({ startTime in
                self.bakeRepository.bake.steps
                    .enumerated()
                    .map({ index, step -> BakeStepCellViewModel in
                        let stepStartTime = self.bakeRepository.bake.steps[0...index]
                            .reduce(startTime) {
                                $0 + $1.startDelay.asTimeInterval
                        }
                        return BakeStepCellViewModel(step: step, startDate: stepStartTime)
                    })
            })
            .assign(to: \.bakeStepCellViewModels, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$steps.map({ steps in
            steps.enumerated().map({ index, step -> BakeStepCellViewModel in
                let stepStartTime = steps[0...index]
                    .reduce(self.bakeRepository.bake.startTime) {
                        $0 + $1.startDelay.asTimeInterval
                }
                return BakeStepCellViewModel(step: step, startDate: stepStartTime)
            })
        })
            .assign(to: \.bakeStepCellViewModels, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$steps
            .map({
                $0.map(\.startDelay)
                    .reduce(self.bakeRepository.bake.finalStepDuration) { $0 + $1 }
            })
            .assign(to: \.bakeDuration, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$finalStepDuration
            .compactMap({ try? TimeCalculator.formatted(duration: $0) })
            .assign(to: \.lastStepDuration, on: self)
            .store(in: &cancellables)
        
        bakeRepository.bake.$finalStepDuration
            .map({
                self.bakeRepository.bake.steps
                    .map(\.startDelay)
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
            TimeCalculator.add($0, to: self.bakeRepository.bake.startTime)
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
        if bakeStepCellViewModels.contains(where: { $0.step.id == step.id }) {
            bakeRepository.updateStep(step)
        } else {
            bakeRepository.addStep(step)
        }
    }
    
    func removeSteps(at offsets: IndexSet) {
        let steps = offsets.lazy.map { self.bakeStepCellViewModels[$0] }
        steps.forEach { bakeStepCellViewModel in
            bakeRepository.removeStep(bakeStepCellViewModel.step)
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
