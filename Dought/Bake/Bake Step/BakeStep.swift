//
//  BakeStep.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

typealias Minutes = Int

struct BakeStep: Identifiable, Codable {
    let id: UUID = UUID()
    var name: String
    var startDelay: Minutes
}

extension BakeStep {
    static func makeNew() -> BakeStep {
        return BakeStep(name: "", startDelay: 0)
    }
}
