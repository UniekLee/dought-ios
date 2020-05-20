//
//  Schedule.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

struct Schedule: Identifiable, Codable {
    let id: UUID = UUID()
    var stages: [Stage]
}


// MARK: - Schedule subtypes
extension Schedule {
    struct Stage: Identifiable, Codable {
        let id: UUID = UUID()
        
        let kind: Kind
        let accentColor: Color
        
        // TODO: Sort by start time
        let steps: [Step]
    }
}

// MARK: - Schedule.Stage subtypes
extension Schedule.Stage {
    enum Kind: String, Codable {
        case levainBuild, mixAndBulkFerment, mix, bulkFerment, knead, shape, proof, bake
    }
    
    enum Color: String, Codable {
        case clear, blue, green, yellow, orange, red
    }
    
    struct Step: Identifiable, Codable {
        let id: UUID = UUID()
        let name: String
        let startTime: Date
    }
}
