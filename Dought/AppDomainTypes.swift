//
//  AppDomainTypes.swift
//  Dought
//
//  Created by Lee Watkins on 26/05/2020.
//  Copyright © 2020 Lee Watkins. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    var bakesList = BakesListState()
}

enum AppAction {
    case bakesList(BakesListAction)
}

struct AppEnvironment {
  var mainQueue: AnySchedulerOf<DispatchQueue>
}

let appReducer: Reducer<AppState, AppAction, AppEnvironment> = .combine(
    bakesListReducer.pullback(state: \AppState.bakesList,
                              action: /AppAction.bakesList,
                              environment: { _ in }
    ),
    Reducer { state, action, _ in
        switch action {
        case .bakesList:
            return .none
        }
})
