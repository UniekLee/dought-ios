//
//  Bake.swift
//  Dought
//
//  Created by Lee Watkins on 13/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

struct Bake: Codable {
    var startTime: Date = TimeCalculator.todayAtNine()
    var steps: [BakeStep] = []
    var finalStepDuration: Minutes = 120
    
    init() {}
    
    // MARK: - Codable Conformance
    enum CodingKeys: CodingKey {
        case startTime, steps, finalStepDuration
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(startTime, forKey: .startTime)
        try container.encode(steps, forKey: .steps)
        try container.encode(finalStepDuration, forKey: .finalStepDuration)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        startTime = try container.decode(Date.self, forKey: .startTime)
        steps = try container.decode([BakeStep].self, forKey: .steps)
        finalStepDuration = try container.decode(Int.self, forKey: .finalStepDuration)
    }
}

extension Bake {
    struct Stage: Identifiable, Codable {
        let id: UUID = UUID()
        
        let accentColor: String
        let name: String
        let dayOfBake: Int
    }
}
