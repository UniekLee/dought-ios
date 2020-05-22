//
//  Formatters.swift
//  Dought
//
//  Created by Lee Watkins on 22/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation

struct Formatter<T> {
    var value: T
}

class Formatters {
//    enum FormatterError: Error {
//        case failed
//    }
    
    static let shared: Formatters = Formatters()
    
//    lazy var plusHMinFormatter: DateComponentsFormatter = {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.hour, .minute]
//        formatter.unitsStyle = .abbreviated
//        formatter.zeroFormattingBehavior = .pad
//        return formatter
//    }()
//
//    lazy var stepStartTimeFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "HH:mm"
//        return formatter
//    }()
}
