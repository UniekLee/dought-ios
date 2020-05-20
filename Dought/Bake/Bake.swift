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
}
