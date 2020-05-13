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
