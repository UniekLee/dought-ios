//
//  BakeStep.swift
//  Dought
//
//  Created by Lee Watkins on 29/04/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

typealias Minutes = Int

struct BakeStep: Identifiable {
    let id: UUID = UUID()
    let name: String
    let duration: Minutes
}
