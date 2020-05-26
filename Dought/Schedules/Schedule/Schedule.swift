//
//  Schedule.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import SwiftUI

struct Schedule: Identifiable, Codable, Hashable {
    
    let id: UUID = UUID()
    let name: String
    let details: String
    
    // TODO: Sort by 1st step's start date
    var stages: [Stage]
}

// MARK: - Schedule subtypes
extension Schedule {
    struct Stage: Identifiable, Codable, Hashable {
        let id: UUID = UUID()
        
        let kind: Kind
        let accent: Accent
        
        // TODO: Sort by start time
        var steps: [Step]
    }
}

// MARK: - Schedule.Stage subtypes
extension Schedule.Stage {
    enum Kind: String, Codable, Hashable {
        case levainBuild, mixAndBulkFerment, mix, bulkFerment, knead, shape, proof, bake
    }
    
    enum Accent: String, Codable, Hashable {
        case clear, blue, green, yellow, orange, red
    }
    
    struct Step: Identifiable, Codable, Hashable {
        let id: UUID = UUID()
        var isComplete: Bool = false
        let name: String
        var startTime: Date
    }
    
    static func empty() -> Schedule.Stage {
        return Schedule.Stage(kind: .bake,
                              accent: .clear,
                              steps: [])
    }
}

extension Schedule {
    func day(of stage: Stage) -> Int {
        guard
            let firstStage = stages.first,
            let firstStep = firstStage.steps.first
            else { return 1 }
        
        guard
            let givenStep = stage.steps.first
            else { return 1 }
        
        let daysDuration = firstStep.startTime.differenceInDays(to: givenStep.startTime)
        
        return 1 + daysDuration
    }
}

extension Schedule.Stage.Kind {
    var title: String {
        switch self {
        case .levainBuild:          return "Levain build"
        case .mixAndBulkFerment:    return "Mix & bulk ferment"
        case .mix:                  return "Mix"
        case .bulkFerment:          return "Bulk ferment"
        case .knead:                return "Knead"
        case .shape:                return "Shape"
        case .proof:                return "Proof"
        case .bake:                 return "Bake"
        }
    }
}

extension Schedule.Stage.Accent {
    var color: Color {
        switch self {
        case .clear:    return .clear
        case .blue:     return .blue
        case .green:    return .green
        case .yellow:   return .yellow
        case .orange:   return .orange
        case .red:      return .red
        }
    }
}
