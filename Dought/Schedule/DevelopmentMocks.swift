//
//  DevelopmentMocks.swift
//  Dought
//
//  Created by Lee Watkins on 20/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

private extension Date {
    private static var formatter: ISO8601DateFormatter = ISO8601DateFormatter()
    
    static func at(_ value: String) -> Date {
        return formatter.date(from: value)!
    }
}

extension Schedule {
    static func devMock() -> Schedule {
        Schedule(name: "Weekend bake",
                 stages: Schedule.Stage.devMock())
    }
}

extension Schedule.Stage {
    static func devMock() -> [Schedule.Stage] {
        return [
            Schedule.Stage.init(kind: .levainBuild,
                                accent: .blue,
                                steps: [
                                    Step(name: "Add levain", startTime: .at("2020-05-22T08:00:00Z")),
                                    Step(name: "Autolyse", startTime: .at("2020-05-22T10:00:00Z")),
            ]),
            Schedule.Stage.init(kind: .mixAndBulkFerment,
                                accent: .green,
                                steps: [
                                    Step(name: "Mix", startTime: .at("2020-05-22T11:00:00Z")),
                                    Step(name: "Stretch & fold #1", startTime: .at("2020-05-22T11:30:00Z")),
                                    Step(name: "Stretch & fold #2", startTime: .at("2020-05-22T12:00:00Z")),
                                    Step(name: "Stretch & fold #3", startTime: .at("2020-05-22T12:30:00Z")),
            ]),
            Schedule.Stage.init(kind: .shape,
                                accent: .yellow,
                                steps: [
                                    Step(name: "Pre-shape", startTime: .at("2020-05-22T16:00:00Z")),
                                    Step(name: "Shape", startTime: .at("2020-05-22T16:30:00Z")),
            ]),
            Schedule.Stage.init(kind: .proof,
                                accent: .orange,
                                steps: [
                                    Step(name: "Refrigerate", startTime: .at("2020-05-22T17:00:00Z")),
            ]),
            Schedule.Stage.init(kind: .bake,
                                accent: .red,
                                steps: [
                                    Step(name: "Preheat oven", startTime: .at("2020-05-23T07:00:00Z")),
                                    Step(name: "Bake covered", startTime: .at("2020-05-23T09:00:00Z")),
                                    Step(name: "Uncover", startTime: .at("2020-05-23T09:20:00Z")),
                                    Step(name: "Remove & cool", startTime: .at("2020-05-23T09:45:00Z")),
            ]),
        ]
    }
}

